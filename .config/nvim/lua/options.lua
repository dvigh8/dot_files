-- [[ Setting options ]] — see `:help vim.o`

-- Line numbers (relative + absolute hybrid).
vim.o.number = true
vim.o.relativenumber = true

-- Mouse on for resizing splits and not much else.
vim.o.mouse = 'a'

-- Mode is in the statusline, no need to duplicate.
vim.o.showmode = false

-- Sync clipboard with the OS. Scheduled to avoid startup hit.
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

vim.o.breakindent = true
vim.o.undofile = true

-- Smartcase search.
vim.o.ignorecase = true
vim.o.smartcase = true

-- Always show signcolumn so the buffer doesn't shift on diagnostics.
vim.o.signcolumn = 'yes'

-- Faster CursorHold + UI updates (gitsigns, LSP hover, etc).
vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Live preview of :s replacements.
vim.o.inccommand = 'split'

vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

-- Treesitter folding by default; start unfolded.
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99

-- Smaller swap/shada for snappier I/O.
vim.o.swapfile = false
vim.o.shada = "!,'500,<50,s10,h"

-- True color (most modern terminals support it).
vim.o.termguicolors = true

-- vim 0.12 native insert-mode autocomplete is opt-in via vim.o.autocomplete.
-- We're using blink.cmp instead, so leave this off — set to true to test natives.
-- vim.o.autocomplete = true

-- vim: ts=2 sts=2 sw=2 et
