-- Active colorscheme. Edit ACTIVE_THEME to switch.
-- Hot reload from omarchy/external sources is set up in lua/util/theme-hotreload.lua,
-- triggered by `:Lazy reload` (User LazyReload event).

local ACTIVE_THEME = 'tokyonight-night'

return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      style = 'night',
      transparent = true,
      styles = {
        sidebars = 'transparent',
        floats = 'transparent',
      },
    },
    config = function(_, opts)
      require('tokyonight').setup(opts)
      vim.cmd.colorscheme(ACTIVE_THEME)
      -- Wire up the hot-reload listener once the theme loads.
      require('util.theme-hotreload').setup(ACTIVE_THEME)
    end,
  },
}
