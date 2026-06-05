-- obsidian.nvim — uses snacks.picker (no telescope dep).
-- Workspace path matches your existing dotfiles. Rename if Atrium uses a
-- different vault path.
return {
  'epwalsh/obsidian.nvim',
  version = '*',
  ft = 'markdown',
  event = {
    'BufReadPre ' .. vim.fn.expand '~' .. '/Documents/Avidity/**.md',
    'BufNewFile ' .. vim.fn.expand '~' .. '/Documents/Avidity/**.md',
  },
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { '<leader>on', '<cmd>ObsidianNew<cr>', desc = '[O]bsidian [N]ew note' },
    { '<leader>od', '<cmd>ObsidianToday<cr>', desc = '[O]bsidian [D]aily note' },
    { '<leader>ol', '<cmd>ObsidianLinks<cr>', desc = '[O]bsidian [L]inks' },
    { '<leader>ob', '<cmd>ObsidianBacklinks<cr>', desc = '[O]bsidian [B]acklinks' },
    { '<leader>ot', '<cmd>ObsidianTemplate<cr>', desc = '[O]bsidian [T]emplate' },
    { '<leader>oo', '<cmd>ObsidianSearch<cr>', desc = '[O]bsidian [O]pen note' },
    { '<leader>os', '<cmd>ObsidianSearch<cr>', desc = '[O]bsidian [S]earch' },
  },
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function()
        local path = vim.fn.expand '%:p'
        if path:match(vim.fn.expand '~' .. '/Documents/Avidity') then
          vim.opt_local.conceallevel = 2
        end
      end,
    })
  end,
  opts = {
    workspaces = {
      { name = 'avidity', path = '~/Documents/Avidity' },
    },
    notes_subdir = 'notes',
    daily_notes = {
      folder = 'daily',
      date_format = '%Y-%m-%d',
      alias_format = '%B %-d, %Y',
      default_tags = { 'daily' },
    },
    templates = {
      folder = 'templates',
      date_format = '%Y-%m-%d',
      time_format = '%H:%M',
    },
    completion = { nvim_cmp = false, blink = true, min_chars = 2 },
    new_notes_location = 'notes_subdir',
    preferred_link_style = 'wiki',
    -- snacks.picker wired up via the `mini` picker fallback (obsidian.nvim's
    -- list of supported pickers is small; mini works with fzf-lua and snacks
    -- through its `vim.ui.select` integration).
    picker = { name = 'snacks.pick' },
    sort_by = 'modified',
    sort_reversed = true,
    open_notes_in = 'current',
    ui = {
      enable = true,
      checkboxes = {
        [' '] = { char = '☐', hl_group = 'ObsidianTodo' },
        ['x'] = { char = '✔', hl_group = 'ObsidianDone' },
        ['>'] = { char = '→', hl_group = 'ObsidianRightArrow' },
        ['~'] = { char = '~', hl_group = 'ObsidianTilde' },
      },
    },
    attachments = { img_folder = 'assets/imgs' },
  },
}
