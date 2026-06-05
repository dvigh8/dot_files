-- A small snacks.picker wrapper over git-worktree.nvim — replaces the
-- telescope extension that ships with that plugin so we don't need telescope.
--
-- Usage:
--   require('util.git-worktree-picker').list()
--   require('util.git-worktree-picker').create()

local M = {}

---@return { path: string, branch: string, head: string, bare: boolean }[]
local function parse_worktree_list()
  local out = vim.fn.systemlist 'git worktree list --porcelain'
  if vim.v.shell_error ~= 0 then return {} end
  local trees = {}
  local cur = nil
  for _, line in ipairs(out) do
    if line:match '^worktree ' then
      if cur then table.insert(trees, cur) end
      cur = { path = line:sub(10), branch = '', head = '', bare = false }
    elseif cur and line:match '^HEAD ' then
      cur.head = line:sub(6)
    elseif cur and line:match '^branch ' then
      cur.branch = line:sub(8):gsub('^refs/heads/', '')
    elseif cur and line == 'bare' then
      cur.bare = true
    end
  end
  if cur then table.insert(trees, cur) end
  return trees
end

function M.list()
  local trees = parse_worktree_list()
  if #trees == 0 then
    vim.notify('No worktrees found (or not a git repo)', vim.log.levels.WARN)
    return
  end

  local items = {}
  for _, t in ipairs(trees) do
    table.insert(items, {
      text = string.format('%-30s  %s', t.branch ~= '' and t.branch or '(detached)', t.path),
      path = t.path,
      branch = t.branch,
    })
  end

  Snacks.picker.pick {
    source = 'git_worktrees',
    title = 'Git Worktrees',
    items = items,
    format = 'text',
    preview = 'none',
    confirm = function(picker, item)
      picker:close()
      if item and item.path then
        local ok, gw = pcall(require, 'git-worktree')
        if ok then
          gw.switch_worktree(item.path)
        else
          vim.cmd('cd ' .. vim.fn.fnameescape(item.path))
          vim.cmd 'edit .'
        end
      end
    end,
    actions = {
      delete = function(picker, item)
        picker:close()
        if item and item.path then
          local ok, gw = pcall(require, 'git-worktree')
          if ok then gw.delete_worktree(item.path) end
        end
      end,
    },
    win = {
      input = {
        keys = {
          ['<C-d>'] = { 'delete', mode = { 'i', 'n' } },
        },
      },
    },
  }
end

function M.create()
  vim.ui.input({ prompt = 'New worktree path (relative or absolute): ' }, function(path)
    if not path or path == '' then return end
    vim.ui.input({ prompt = 'Branch name: ' }, function(branch)
      if not branch or branch == '' then return end
      vim.ui.input({ prompt = 'Upstream (blank = none): ' }, function(upstream)
        local ok, gw = pcall(require, 'git-worktree')
        if ok then
          gw.create_worktree(path, branch, upstream ~= '' and upstream or nil)
        end
      end)
    end)
  end)
end

return M
