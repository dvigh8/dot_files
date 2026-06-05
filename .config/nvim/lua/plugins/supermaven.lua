return {
  'supermaven-inc/supermaven-nvim',
  event = 'InsertEnter',
  opts = {
    keymaps = {
      accept_suggestion = '<C-y>',
      clear_suggestion = '<C-]>',
      accept_word = '<C-l>',
    },
    disable_inline_completion = false,
  },
  config = function(_, opts) require('supermaven-nvim').setup(opts) end,
}
