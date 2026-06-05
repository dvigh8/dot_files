-- Harpoon (v2). Same keymaps as your old configs.
return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { '<leader>la', function() require('harpoon'):list():add() end, desc = 'Harpoon: [A]dd file' },
    { '<C-e>', function() local h = require 'harpoon' h.ui:toggle_quick_menu(h:list()) end, desc = 'Harpoon: menu' },
    { '<C-1>', function() require('harpoon'):list():select(1) end, desc = 'Harpoon: 1' },
    { '<C-2>', function() require('harpoon'):list():select(2) end, desc = 'Harpoon: 2' },
    { '<C-3>', function() require('harpoon'):list():select(3) end, desc = 'Harpoon: 3' },
    { '<C-4>', function() require('harpoon'):list():select(4) end, desc = 'Harpoon: 4' },
    { '<leader><C-1>', function() require('harpoon'):list():replace_at(1) end, desc = 'Harpoon: replace 1' },
    { '<leader><C-2>', function() require('harpoon'):list():replace_at(2) end, desc = 'Harpoon: replace 2' },
    { '<leader><C-3>', function() require('harpoon'):list():replace_at(3) end, desc = 'Harpoon: replace 3' },
    { '<leader><C-4>', function() require('harpoon'):list():replace_at(4) end, desc = 'Harpoon: replace 4' },
  },
  config = function() require('harpoon'):setup() end,
}
