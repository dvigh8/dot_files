-- nvim-lint — linters that aren't LSPs (shellcheck, ruff, eslint_d, markdownlint).
return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'
    lint.linters_by_ft = {
      sh = { 'shellcheck' },
      bash = { 'shellcheck' },
      markdown = { 'markdownlint' },
      python = { 'ruff' },
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
    }
    local group = vim.api.nvim_create_augroup('nvim_lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
      group = group,
      callback = function() lint.try_lint() end,
    })
  end,
}
