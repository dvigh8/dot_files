-- nvim-treesitter on the `main` branch (the rewrite). The legacy `master`
-- branch exposed `require('nvim-treesitter.configs').setup(...)`; that module
-- does NOT exist on `main`. The new API:
--   - require('nvim-treesitter').install(parsers)
--   - vim.treesitter.start(buf, language)
--   - vim.treesitter.query.get(lang, 'indents') for indent
--
-- Highlighting + indent are attached on FileType. Auto-install kicks in for
-- any filetype with an available parser.
return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local parsers = {
        'bash', 'c', 'diff', 'html', 'lua', 'luadoc',
        'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc',
        'python', 'go', 'rust', 'typescript', 'tsx', 'javascript',
        'json', 'yaml', 'toml', 'regex', 'gitcommit', 'gitignore',
      }
      require('nvim-treesitter').install(parsers)

      -- Big-file guard — snacks.bigfile also disables features, but cheap belt-and-suspenders.
      local MAX_FILESIZE = 256 * 1024

      ---@param buf integer
      ---@param language string
      local function attach(buf, language)
        local ok = vim.treesitter.language.add(language)
        if not ok then return end
        vim.treesitter.start(buf, language)
        local has_indent = vim.treesitter.query.get(language, 'indents') ~= nil
        if has_indent then vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
      end

      local available = require('nvim-treesitter').get_available()
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('user_treesitter_attach', { clear = true }),
        callback = function(args)
          local buf, filetype = args.buf, args.match

          -- Skip very large files.
          local ok_stat, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok_stat and stats and stats.size > MAX_FILESIZE then return end

          local language = vim.treesitter.language.get_lang(filetype)
          if not language then return end

          local installed = require('nvim-treesitter').get_installed 'parsers'
          if vim.tbl_contains(installed, language) then
            attach(buf, language)
          elseif vim.tbl_contains(available, language) then
            require('nvim-treesitter').install(language):await(function() attach(buf, language) end)
          else
            attach(buf, language)
          end
        end,
      })
    end,
  },
}
