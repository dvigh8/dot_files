-- [[ Basic Keymaps ]] — plugin keymaps live in their plugin specs.

local map = vim.keymap.set

-- Clear search highlight on <Esc>.
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostics: jump using the new vim.diagnostic.jump (replaces goto_prev/next, deprecated in 0.11+).
map('n', ']d', function() vim.diagnostic.jump { count = 1, float = true } end, { desc = 'Next [D]iagnostic' })
map('n', '[d', function() vim.diagnostic.jump { count = -1, float = true } end, { desc = 'Prev [D]iagnostic' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Diagnostic float' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostic [Q]uickfix' })

-- Don't yank when deleting single chars / pasting over selection.
map({ 'n', 'v' }, 'x', '"_x', { desc = 'Delete char without yanking' })
map('x', 'p', [["_dp]], { desc = 'Paste without yanking selection' })

-- Better window navigation.
map('n', '<C-h>', '<C-w>h', { desc = 'Window left' })
map('n', '<C-l>', '<C-w>l', { desc = 'Window right' })
map('n', '<C-j>', '<C-w>j', { desc = 'Window down' })
map('n', '<C-k>', '<C-w>k', { desc = 'Window up' })

-- Move lines up/down in visual mode.
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Keep cursor centered on half-page jumps and search.
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- Quick save/quit.
map('n', '<leader>w', '<cmd>write<cr>', { desc = '[W]rite buffer' })
map('n', '<leader>Q', '<cmd>quitall<cr>', { desc = 'Quit all' })

-- Resize windows with arrows.
map('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase height' })
map('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase width' })

-- Highlight on yank — moved to autocmds.lua so it doesn't run on every load.

-- Terminal: <Esc><Esc> to exit insert mode.
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Terminal: exit insert' })

-- vim: ts=2 sts=2 sw=2 et
