-- Theme hot reload: when `:Lazy reload` fires (User LazyReload event), re-source
-- the active colorscheme + the transparency layer. Useful if you change the
-- ACTIVE_THEME in plugins/theme.lua and want it to apply without restarting nvim.
--
-- Or if an external system (omarchy) writes the value into a file and triggers
-- :Lazy reload via an FS watcher.

local M = {}

function M.setup(active_theme)
  vim.api.nvim_create_autocmd('User', {
    pattern = 'LazyReload',
    callback = function()
      vim.schedule(function()
        -- Clear highlights so dark/light themes apply cleanly.
        vim.cmd 'highlight clear'
        if vim.fn.exists 'syntax_on' == 1 then vim.cmd 'syntax reset' end
        vim.o.background = 'dark'

        -- Bust the active theme's lua modules so they reload.
        local plugin = require('lazy.core.config').plugins[active_theme]
          or require('lazy.core.config').plugins[active_theme:gsub('-.*$', '')]
        if plugin and plugin.dir then
          local plugin_dir = plugin.dir .. '/lua'
          if vim.fn.isdirectory(plugin_dir) == 1 then
            require('lazy.core.util').walkmods(plugin_dir, function(modname)
              package.loaded[modname] = nil
              package.preload[modname] = nil
            end)
          end
        end

        -- Apply the colorscheme.
        vim.defer_fn(function()
          pcall(vim.cmd.colorscheme, active_theme)
          vim.cmd 'redraw!'
          -- transparency.lua (in plugin/) re-runs on ColorScheme; no extra source needed.
          vim.api.nvim_exec_autocmds('ColorScheme', { modeline = false })
        end, 5)
      end)
    end,
  })
end

return M
