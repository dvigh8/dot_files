-- =====================================================================
-- David Vigh — Neovim 0.12 config
-- Foundation: kickstart-modular layout, lazy.nvim, snacks.picker, blink.cmp
-- Goal: fast startup. Most plugins lazy-loaded by event/cmd/keys/ft.
-- =====================================================================

-- Enable Lua bytecode cache (one of the biggest startup wins; nvim 0.9+).
-- This must run before any `require` of plugin modules.
if vim.loader then vim.loader.enable() end

-- Leader keys must be set before plugins load.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Nerd Font is assumed (Atrium dotfiles ship one). Set false to fall back to ASCII.
vim.g.have_nerd_font = true

-- Disable a few rtp plugins we never use. Saves ~1-3ms.
local disabled_built_ins = {
  'gzip',
  'tarPlugin',
  'tohtml',
  'tutor',
  'zipPlugin',
  'netrwPlugin', -- yazi replaces netrw
}
for _, plugin in ipairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

-- Defer provider checks to when they're actually needed.
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- [[ Setting options ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'

-- [[ Autocmds ]]
require 'autocmds'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'

-- [[ Configure and install plugins ]]
require 'lazy-plugins'

-- vim: ts=2 sts=2 sw=2 et
