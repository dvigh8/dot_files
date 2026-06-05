-- which-key — keymap discovery. Loads on VeryLazy so first key press is fast.
return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    delay = 0,
    icons = { mappings = vim.g.have_nerd_font },
    spec = {
      { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
      { '<leader>f', group = '[F]ind' },
      { '<leader>g', group = '[G]it' },
      { '<leader>l', group = '[L]ist' },
      { '<leader>o', group = '[O]bsidian' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>u', group = '[U]I toggles' },
      { '<leader>w', group = '[W]rite' },
      { '<leader>x', group = 'Diagnostics/Trouble' },
    },
  },
  keys = {
    { '<leader>?', function() require('which-key').show { global = false } end, desc = 'Buffer Local Keymaps' },
  },
}
