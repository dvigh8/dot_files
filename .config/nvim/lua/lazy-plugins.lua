-- [[ Configure and install plugins ]]
--
-- Layout: one file per plugin in lua/plugins/. lazy.nvim auto-imports the directory.
-- Run :Lazy to manage. :Lazy profile shows startup attribution.

require('lazy').setup({
  spec = {
    { import = 'plugins' },
  },
  defaults = {
    -- Force every plugin to be lazy-loaded by default; specs that need eager loading
    -- declare it explicitly via `lazy = false` (theme, treesitter, dashboard, etc).
    lazy = true,
    version = false, -- always use the latest git commit
  },
  -- Lockfile lives in the config dir. We want this in version control.
  install = { colorscheme = { 'tokyonight' } },
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘', config = '🛠', event = '📅', ft = '📂', init = '⚙',
      keys = '🗝', plugin = '🔌', runtime = '💻', require = '🌙',
      source = '📄', start = '🚀', task = '📌', lazy = '💤 ',
    },
  },
  checker = {
    enabled = false, -- run :Lazy check manually; periodic checks add jitter.
    notify = false,
  },
  change_detection = {
    enabled = true,
    notify = false, -- still reload on config changes, but quietly.
  },
  performance = {
    cache = { enabled = true },
    reset_packpath = true,
    rtp = {
      reset = true,
      disabled_plugins = {
        'gzip', 'tarPlugin', 'tohtml', 'tutor', 'zipPlugin', 'netrwPlugin',
        -- We re-enable matchit/matchparen because mini.surround/mini.ai don't fully replace them.
        -- 'matchit', 'matchparen',
      },
    },
  },
}, { ---@diagnostic disable-line: missing-fields
})

-- vim: ts=2 sts=2 sw=2 et
