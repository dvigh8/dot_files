-- lazygit — full TUI in a floating window. snacks.lazygit handles the wrapping
-- with no extra plugin needed (snacks already loaded). Keymaps below.
return {
  -- A noop spec — keeps the file in lua/plugins/ so it shows up in discovery,
  -- but no plugin is actually installed. Snacks owns the integration.
  {
    'folke/snacks.nvim',
    keys = {
      { '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazygit (cwd)' },
      { '<leader>gG', function() Snacks.lazygit { cwd = vim.fn.expand '%:p:h' } end, desc = 'Lazygit (file dir)' },
      { '<leader>gL', function() Snacks.lazygit.log() end, desc = 'Lazygit log (cwd)' },
      { '<leader>gF', function() Snacks.lazygit.log_file() end, desc = 'Lazygit log (file)' },
    },
  },
}
