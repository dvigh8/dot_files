-- Auto-applied transparency layer.
-- nvim sources every file under `plugin/` at startup; this re-runs on every
-- ColorScheme event so it survives theme switches.

local function make_transparent(name)
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
  if ok then
    hl.bg = nil
    vim.api.nvim_set_hl(0, name, hl)
  end
end

local groups = {
  -- core
  'Normal', 'NormalFloat', 'NormalNC', 'FloatBorder', 'Pmenu',
  'Terminal', 'EndOfBuffer', 'FoldColumn', 'Folded', 'SignColumn',
  'LineNr', 'CursorLineNr',
  -- which-key
  'WhichKeyFloat',
  -- snacks
  'SnacksDashboardNormal', 'SnacksPickerListBorder', 'SnacksNormal',
  'SnacksPickerInputBorder', 'SnacksPickerPreviewBorder',
  -- notify (snacks notifier)
  'SnacksNotifierInfo', 'SnacksNotifierError', 'SnacksNotifierWarn',
  'SnacksNotifierBorder',
  -- legacy plugins (kept in case you re-enable them)
  'TelescopeBorder', 'TelescopeNormal', 'TelescopePromptBorder',
  'NeoTreeNormal', 'NeoTreeNormalNC', 'NeoTreeVertSplit', 'NeoTreeWinSeparator', 'NeoTreeEndOfBuffer',
}

local function apply()
  for _, name in ipairs(groups) do make_transparent(name) end
end

vim.api.nvim_create_autocmd({ 'ColorScheme', 'VimEnter' }, {
  group = vim.api.nvim_create_augroup('user_transparency', { clear = true }),
  callback = apply,
})

apply()
