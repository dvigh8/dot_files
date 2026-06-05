-- LSP setup using nvim 0.11+'s native vim.lsp.config / vim.lsp.enable APIs.
-- nvim-lspconfig is still imported for its configs in `lspconfig.configs.<name>`,
-- but we don't call lspconfig.setup() — we use the new native API instead.
--
-- This means servers register via vim.lsp.config('name', { ... }) and start
-- automatically when matching filetypes open.

return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      -- Mason: keep as a side dep but don't gate LSP on it.
      { 'mason-org/mason.nvim', opts = {} },
      { 'mason-org/mason-lspconfig.nvim' },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
      -- Lua dev for editing this very config.
      { 'folke/lazydev.nvim', ft = 'lua', opts = {
        library = { { path = '${3rd}/luv/library', words = { 'vim%.uv' } } },
      } },
      'saghen/blink.cmp', -- for capabilities
    },
    config = function()
      -- Diagnostics UI.
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or true,
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          prefix = '●',
        },
      }

      -- Per-buffer LSP keymaps. gd/gr/etc come from snacks.lua via the picker;
      -- here we add the LSP-specific ones.
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('user_lsp_attach', { clear = true }),
        callback = function(event)
          local bufmap = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          bufmap('<leader>cr', vim.lsp.buf.rename, '[C]ode [R]ename')
          bufmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
          bufmap('K', vim.lsp.buf.hover, 'Hover Documentation')
          bufmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Help', 'i')
          bufmap('<leader>cf', function() vim.lsp.buf.format { async = true } end, '[C]ode [F]ormat')
          -- Inlay hints toggle (0.10+).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method 'textDocument/inlayHint' then
            bufmap('<leader>uh', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }, { bufnr = event.buf })
            end, 'Toggle Inlay [H]ints')
          end
        end,
      })

      -- Combine blink.cmp's capabilities with the defaults.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

      -- Default config applied to every server.
      vim.lsp.config('*', { capabilities = capabilities })

      ---@type table<string, vim.lsp.Config>
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
        bashls = {},
        pyright = {},
        ts_ls = {},
        gopls = {},
        rust_analyzer = {},
        jsonls = {},
        yamlls = {},
        marksman = {},
      }

      -- Tools we want available even if the LSP itself is somewhere else.
      local tools = {
        'stylua', 'shfmt', 'shellcheck',
        'prettier', 'prettierd', 'eslint_d',
        'black', 'isort', 'ruff',
        'goimports',
      }

      -- Register servers natively.
      for name, opts in pairs(servers) do
        vim.lsp.config(name, opts)
      end

      require('mason-lspconfig').setup {
        ensure_installed = vim.tbl_keys(servers),
        automatic_installation = true,
        -- automatic_enable = true tells mason-lspconfig to call vim.lsp.enable for each.
        automatic_enable = true,
      }

      require('mason-tool-installer').setup {
        ensure_installed = tools,
        run_on_start = true,
      }
    end,
  },
}
