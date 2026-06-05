-- All the alternate colorschemes you switch between via omarchy hot-reload.
-- Each is `lazy = true`: lazy.nvim won't download or load them until you
-- `:colorscheme <name>` or the hot-reload module asks for them.

local function theme(repo, name)
  return {
    repo,
    name = name,
    lazy = true,
    priority = 1000,
  }
end

return {
  theme('ribru17/bamboo.nvim'),
  theme('bjarneo/aether.nvim'),
  theme('bjarneo/ethereal.nvim'),
  theme('bjarneo/hackerman.nvim'),
  theme('catppuccin/nvim', 'catppuccin'),
  theme('sainnhe/everforest'),
  theme('kepano/flexoki-neovim'),
  theme('ellisonleao/gruvbox.nvim'),
  theme('rebelot/kanagawa.nvim'),
  theme('tahayvr/matteblack.nvim'),
  theme('loctvl842/monokai-pro.nvim'),
  theme('shaunsingh/nord.nvim'),
  theme('rose-pine/neovim', 'rose-pine'),
}
