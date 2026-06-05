-- gitsigns — gutter signs, hunks, blame.
return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  ---@type Gitsigns.Config
  opts = {
    signs = {
      add = { text = '┃' },
      change = { text = '┃' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
    },
    on_attach = function(buffer)
      local gs = package.loaded.gitsigns
      local map = function(mode, l, r, desc) vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc }) end

      map('n', ']h', function()
        if vim.wo.diff then return ']h' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, 'Next hunk')
      map('n', '[h', function()
        if vim.wo.diff then return '[h' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, 'Prev hunk')

      map('n', '<leader>gs', gs.stage_hunk, 'Stage hunk')
      map('n', '<leader>gr', gs.reset_hunk, 'Reset hunk')
      map('v', '<leader>gs', function() gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, 'Stage hunk')
      map('v', '<leader>gr', function() gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, 'Reset hunk')
      map('n', '<leader>gp', gs.preview_hunk, 'Preview hunk')
      map('n', '<leader>gB', function() gs.blame_line { full = true } end, 'Blame line')
      map('n', '<leader>gtd', gs.toggle_deleted, 'Toggle deleted')
    end,
  },
}
