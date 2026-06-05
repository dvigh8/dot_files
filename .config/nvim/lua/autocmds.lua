-- [[ Autocommands ]] — keep this short. Plugin autocmds live in their plugin specs.

local augroup = function(name) return vim.api.nvim_create_augroup('user_' .. name, { clear = true }) end

-- Highlight on yank.
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup 'yank_highlight',
  callback = function() vim.hl.on_yank() end, -- vim.hl.* in 0.11+; was vim.highlight.* before.
})

-- Auto-reload buffers when files change on disk (used by opencode flow).
vim.o.autoread = true
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
  group = augroup 'autoreload',
  callback = function()
    if vim.fn.getcmdwintype() == '' then vim.cmd 'checktime' end
  end,
})
vim.api.nvim_create_autocmd('FileChangedShellPost', {
  group = augroup 'autoreload_notify',
  callback = function() vim.notify('File reloaded (changed externally)', vim.log.levels.INFO) end,
})

-- Trim trailing whitespace on save (skip markdown so Obsidian linebreaks survive).
vim.api.nvim_create_autocmd('BufWritePre', {
  group = augroup 'trim_whitespace',
  callback = function()
    if vim.bo.filetype == 'markdown' then return end
    local view = vim.fn.winsaveview()
    vim.cmd [[silent! %s/\s\+$//e]]
    vim.fn.winrestview(view)
  end,
})

-- Restore cursor position when reopening a buffer.
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup 'restore_cursor',
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local lcount = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Close some auxiliary windows with `q`.
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'close_with_q',
  pattern = { 'help', 'man', 'qf', 'lspinfo', 'checkhealth', 'notify', 'snacks_notif_history' },
  callback = function(args)
    vim.bo[args.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = args.buf, silent = true })
  end,
})

-- vim: ts=2 sts=2 sw=2 et
