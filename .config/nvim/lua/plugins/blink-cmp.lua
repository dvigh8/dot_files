-- blink.cmp — fast, native completion. Loaded on InsertEnter so it doesn't
-- hit startup. Sources include LSP, snippets (LuaSnip), buffer, path.
return {
  'saghen/blink.cmp',
  event = { 'InsertEnter', 'CmdlineEnter' },
  version = '*', -- has prebuilt binaries; release tags only.
  dependencies = {
    { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    'rafamadriz/friendly-snippets',
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'default',
      ['<C-y>'] = { 'select_and_accept', 'fallback' },
      ['<Tab>'] = { 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
    },
    appearance = {
      nerd_font_variant = 'mono',
    },
    completion = {
      accept = { auto_brackets = { enabled = true } },
      menu = { border = 'rounded', draw = { treesitter = { 'lsp' } } },
      documentation = { auto_show = true, auto_show_delay_ms = 200, window = { border = 'rounded' } },
      ghost_text = { enabled = false }, -- supermaven owns ghost text
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
      },
    },
    snippets = { preset = 'luasnip' },
    signature = { enabled = true, window = { border = 'rounded' } },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },
  opts_extend = { 'sources.default' },
}
