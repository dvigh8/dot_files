-- opencode.nvim — keymaps you've been using carry across.
-- The autoreload autocmds live in lua/autocmds.lua so they apply globally.
return {
  'NickvanDyke/opencode.nvim',
  -- All entry points are keymaps, so we lazy-load on the first one.
  keys = {
    { '<C-a>', function() require('opencode').ask('@this: ', { submit = true }) end, mode = { 'n', 'x' }, desc = 'Ask opencode' },
    { '<C-x>', function() require('opencode').select() end, mode = { 'n', 'x' }, desc = 'opencode action…' },
    { '<C-.>', function() require('opencode').toggle() end, mode = { 'n', 't' }, desc = 'Toggle opencode' },
    {
      'go',
      function() return require('opencode').operator '@this ' end,
      mode = { 'n', 'x' },
      expr = true,
      desc = 'Add range to opencode',
    },
    {
      'goo',
      function() return require('opencode').operator('@this ') .. '_' end,
      mode = 'n',
      expr = true,
      desc = 'Add line to opencode',
    },
    { '<S-C-u>', function() require('opencode').command 'session.half.page.up' end, desc = 'opencode half page up' },
    { '<S-C-d>', function() require('opencode').command 'session.half.page.down' end, desc = 'opencode half page down' },
    -- These also live as their own keymaps because you wired + and - to them.
    { '+', '<C-a>', desc = 'Increment / opencode ask', noremap = true },
    { '-', '<C-x>', desc = 'Decrement / opencode action', noremap = true },
  },
  dependencies = {
    -- snacks already loaded by lua/plugins/snacks.lua; opencode just needs it
    -- on the rtp by the time it runs.
    'folke/snacks.nvim',
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      provider = {
        snacks = {
          win = { enter = true },
        },
      },
    }
  end,
}
