-- persistence.nvim (Folke's) — auto-restore sessions.
-- Smaller and more idiomatic with snacks than auto-session, no telescope dep.
-- The dashboard's `s` key (Snacks dashboard 'session' section) integrates with
-- this automatically.
return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  ---@module 'persistence'
  ---@type Persistence.Config
  opts = {
    options = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp' },
  },
  keys = {
    { '<leader>qs', function() require('persistence').load() end, desc = 'Restore Session (cwd)' },
    { '<leader>qS', function() require('persistence').select() end, desc = 'Select Session' },
    { '<leader>ql', function() require('persistence').load { last = true } end, desc = 'Restore Last Session' },
    { '<leader>qd', function() require('persistence').stop() end, desc = "Don't save current session" },
  },
}
