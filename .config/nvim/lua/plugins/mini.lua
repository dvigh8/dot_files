-- mini.nvim — pulls in only the modules we use. Each module is a separate require,
-- so dead modules don't ship into runtime.
return {
  {
    'nvim-mini/mini.ai',
    event = 'VeryLazy',
    opts = function()
      local ai = require 'mini.ai'
      return { n_lines = 500, custom_textobjects = { o = ai.gen_spec.treesitter { a = { '@block.outer', '@conditional.outer', '@loop.outer' }, i = { '@block.inner', '@conditional.inner', '@loop.inner' } } } }
    end,
  },
  {
    'nvim-mini/mini.surround',
    keys = { { 'gz', desc = '+surround' } },
    opts = {
      mappings = {
        add = 'gza',
        delete = 'gzd',
        find = 'gzf',
        find_left = 'gzF',
        highlight = 'gzh',
        replace = 'gzr',
        update_n_lines = 'gzn',
      },
    },
  },
  {
    'nvim-mini/mini.pairs',
    event = 'InsertEnter',
    opts = {},
  },
  {
    'nvim-mini/mini.icons',
    lazy = true,
    opts = {},
    init = function()
      package.preload['nvim-web-devicons'] = function()
        require('mini.icons').mock_nvim_web_devicons()
        return package.loaded['nvim-web-devicons']
      end
    end,
  },
  {
    'nvim-mini/mini.statusline',
    event = 'VeryLazy',
    opts = { use_icons = vim.g.have_nerd_font },
  },
}
