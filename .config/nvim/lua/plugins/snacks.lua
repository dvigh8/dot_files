-- snacks.nvim — picker, dashboard, notifier, terminal, input, indent guides.
-- One plugin replacing six. Loaded eagerly because the dashboard runs at VimEnter
-- and other modules attach autocmds we want available everywhere.
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- Which modules are enabled. Disabled ones cost ~zero.
    bigfile = { enabled = true }, -- disable expensive features in big files
    quickfile = { enabled = true }, -- render files instantly before plugins load
    indent = { enabled = true, animate = { enabled = false } },
    input = { enabled = true },
    notifier = { enabled = true, timeout = 3000 },
    picker = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = false }, -- you turned this off in your old config
    statuscolumn = { enabled = true },
    terminal = { enabled = true },
    words = { enabled = true },

    dashboard = {
      enabled = true,
      preset = {
        header = [[
   ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
   ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
   ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
   ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
   ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
   ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝
]],
        keys = {
          { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
          { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
          { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath('config') })" },
          { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
          { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
        { pane = 2, icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
        { pane = 2, icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
        {
          pane = 2,
          icon = ' ',
          title = 'Git Status',
          section = 'terminal',
          enabled = function() return Snacks.git.get_root() ~= nil end,
          cmd = 'git status --short --branch --renames',
          height = 5,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
        { section = 'startup' },
      },
    },

    styles = {
      input = { keys = { i_esc = { '<Esc>', { 'cancel' }, mode = 'i', expr = true } } },
      notification = { wo = { wrap = true } },
    },
  },
  keys = {
    -- Pickers (replaces telescope keymaps).
    { '<leader><space>', function() Snacks.picker.smart() end, desc = 'Smart Find Files' },
    { '<leader>,', function() Snacks.picker.buffers() end, desc = 'Buffers' },
    { '<leader>/', function() Snacks.picker.grep() end, desc = 'Grep' },
    { '<leader>:', function() Snacks.picker.command_history() end, desc = 'Command History' },
    { '<leader>n', function() Snacks.picker.notifications() end, desc = 'Notification History' },
    -- Find
    { '<leader>fb', function() Snacks.picker.buffers() end, desc = '[F]ind [B]uffers' },
    { '<leader>fc', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, desc = '[F]ind [C]onfig' },
    { '<leader>ff', function() Snacks.picker.files() end, desc = '[F]ind [F]iles' },
    { '<leader>fg', function() Snacks.picker.git_files() end, desc = '[F]ind [G]it Files' },
    { '<leader>fp', function() Snacks.picker.projects() end, desc = '[F]ind [P]rojects' },
    { '<leader>fr', function() Snacks.picker.recent() end, desc = '[F]ind [R]ecent' },
    -- Search
    { '<leader>s/', function() Snacks.picker.search_history() end, desc = 'Search History' },
    { '<leader>sa', function() Snacks.picker.autocmds() end, desc = '[S]earch [A]utocmds' },
    { '<leader>sb', function() Snacks.picker.lines() end, desc = '[S]earch lines in [B]uffer' },
    { '<leader>sB', function() Snacks.picker.grep_buffers() end, desc = '[S]earch in open [B]uffers' },
    { '<leader>sc', function() Snacks.picker.command_history() end, desc = '[S]earch [C]ommand history' },
    { '<leader>sC', function() Snacks.picker.commands() end, desc = '[S]earch [C]ommands' },
    { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = '[S]earch [D]iagnostics' },
    { '<leader>sh', function() Snacks.picker.help() end, desc = '[S]earch [H]elp' },
    { '<leader>sH', function() Snacks.picker.highlights() end, desc = '[S]earch [H]ighlights' },
    { '<leader>sj', function() Snacks.picker.jumps() end, desc = '[S]earch [J]umps' },
    { '<leader>sk', function() Snacks.picker.keymaps() end, desc = '[S]earch [K]eymaps' },
    { '<leader>sl', function() Snacks.picker.loclist() end, desc = '[S]earch [L]ocation list' },
    { '<leader>sm', function() Snacks.picker.marks() end, desc = '[S]earch [M]arks' },
    { '<leader>sM', function() Snacks.picker.man() end, desc = '[S]earch [M]an pages' },
    { '<leader>sp', function() Snacks.picker.lazy() end, desc = '[S]earch [P]lugin specs' },
    { '<leader>sq', function() Snacks.picker.qflist() end, desc = '[S]earch [Q]uickfix' },
    { '<leader>sR', function() Snacks.picker.resume() end, desc = '[S]earch [R]esume' },
    { '<leader>sr', function() Snacks.picker.registers() end, desc = '[S]earch [R]egisters' },
    { '<leader>su', function() Snacks.picker.undo() end, desc = '[S]earch [U]ndo history' },
    { '<leader>sw', function() Snacks.picker.grep_word() end, desc = '[S]earch current [W]ord', mode = { 'n', 'x' } },
    -- Git
    { '<leader>gB', function() Snacks.gitbrowse() end, desc = 'Git [B]rowse', mode = { 'n', 'v' } },
    { '<leader>gb', function() Snacks.picker.git_log_line() end, desc = 'Git [B]lame line' },
    { '<leader>gd', function() Snacks.picker.git_diff() end, desc = 'Git [D]iff (hunks)' },
    { '<leader>gf', function() Snacks.picker.git_log_file() end, desc = 'Git Log [F]ile' },
    { '<leader>gl', function() Snacks.picker.git_log() end, desc = 'Git [L]og' },
    { '<leader>gs', function() Snacks.picker.git_status() end, desc = 'Git [S]tatus' },
    -- LSP via picker
    { 'gd', function() Snacks.picker.lsp_definitions() end, desc = '[G]oto [D]efinition' },
    { 'gD', function() Snacks.picker.lsp_declarations() end, desc = '[G]oto [D]eclaration' },
    { 'gr', function() Snacks.picker.lsp_references() end, nowait = true, desc = '[G]oto [R]eferences' },
    { 'gI', function() Snacks.picker.lsp_implementations() end, desc = '[G]oto [I]mplementation' },
    { 'gy', function() Snacks.picker.lsp_type_definitions() end, desc = '[G]oto T[y]pe Definition' },
    { '<leader>ss', function() Snacks.picker.lsp_symbols() end, desc = 'LSP [S]ymbols' },
    { '<leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, desc = 'LSP Workspace [S]ymbols' },
    -- Misc
    { '<leader>z', function() Snacks.zen() end, desc = 'Toggle [Z]en mode' },
    { '<leader>.', function() Snacks.scratch() end, desc = 'Toggle Scratch Buffer' },
    { '<leader>S', function() Snacks.scratch.select() end, desc = '[S]elect Scratch Buffer' },
    { '<C-/>', function() Snacks.terminal() end, desc = 'Toggle Terminal' },
    { ']]', function() Snacks.words.jump(vim.v.count1) end, desc = 'Next Reference', mode = { 'n', 't' } },
    { '[[', function() Snacks.words.jump(-vim.v.count1) end, desc = 'Prev Reference', mode = { 'n', 't' } },
  },
  init = function()
    -- Use Snacks.notify for `vim.notify` and Snacks.input for `vim.ui.input` etc.
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        ---@diagnostic disable: undefined-global
        _G.dd = function(...) Snacks.debug.inspect(...) end
        _G.bt = function() Snacks.debug.backtrace() end
        vim.print = _G.dd
        Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
        Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
        Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
        Snacks.toggle.diagnostics():map '<leader>ud'
        Snacks.toggle.line_number():map '<leader>ul'
        Snacks.toggle.indent():map '<leader>ug'
        Snacks.toggle.dim():map '<leader>uD'
      end,
    })
  end,
}
