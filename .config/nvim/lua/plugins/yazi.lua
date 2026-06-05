return {
  'mikavilpas/yazi.nvim',
  version = '*',
  -- Lazy-load on the keymaps that open it. We disabled netrw in init.lua,
  -- so yazi is the only file browser.
  keys = {
    { '<leader>-', '<cmd>Yazi<cr>', mode = { 'n', 'v' }, desc = 'Open yazi at the current file' },
    { '<leader>cw', '<cmd>Yazi cwd<cr>', desc = "Open yazi in nvim's cwd" },
    { '<C-Up>', '<cmd>Yazi toggle<cr>', desc = 'Resume yazi' },
  },
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    open_for_directories = false,
    keymaps = { show_help = '<f1>' },
  },
}
