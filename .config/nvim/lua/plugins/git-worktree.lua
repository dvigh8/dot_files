-- git-worktree — uses our snacks.picker wrapper instead of telescope, so we
-- don't pull in telescope just for this.
return {
  'ThePrimeagen/git-worktree.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    {
      '<leader>gw',
      function() require('util.git-worktree-picker').list() end,
      desc = 'Worktrees: list/switch',
    },
    {
      '<leader>gW',
      function() require('util.git-worktree-picker').create() end,
      desc = 'Worktrees: create new',
    },
  },
  config = function()
    local Worktree = require 'git-worktree'
    Worktree.setup {
      change_directory_command = 'cd',
      update_on_change = true,
      update_on_change_command = 'e .',
      clearjumps_on_change = true,
      autopush = false,
    }

    Worktree.on_tree_change(function(op, metadata)
      if op == Worktree.Operations.Switch then
        vim.notify(string.format('Switched to %s', metadata.path), vim.log.levels.INFO)
        vim.fn.system('zoxide add ' .. vim.fn.shellescape(metadata.path))
      elseif op == Worktree.Operations.Create then
        vim.notify(string.format('Created worktree %s on %s', metadata.path, metadata.branch), vim.log.levels.INFO)
        vim.fn.system('zoxide add ' .. vim.fn.shellescape(metadata.path))
      elseif op == Worktree.Operations.Delete then
        vim.notify(string.format('Deleted worktree %s', metadata.path), vim.log.levels.INFO)
      end
    end)
  end,
}
