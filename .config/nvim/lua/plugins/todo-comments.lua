return {
  'folke/todo-comments.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { '<leader>st', function() Snacks.picker.todo_comments() end, desc = '[S]earch [T]odo Comments' },
    { ']t', function() require('todo-comments').jump_next() end, desc = 'Next todo comment' },
    { '[t', function() require('todo-comments').jump_prev() end, desc = 'Prev todo comment' },
  },
  opts = { signs = false },
}
