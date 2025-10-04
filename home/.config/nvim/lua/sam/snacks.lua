local M = {}

-- Helper to safely require a module
local function safe_require(mod)
  local ok, lib = pcall(require, mod)
  if ok then
    return lib
  end
  return nil
end

local project = safe_require("project.api")

-- Find files in config root (similar to search_configs in telescope.lua)
function M.search_configs()
  local cfg_home = vim.env.XDG_CONFIG_HOME or (vim.fn.stdpath("config") .. "/..")
  require("snacks").picker.files({
    cwd = cfg_home,
    hidden = true,
    follow = true,
    prompt = "< Config >",
  })
end

-- Internal: set project directory if project.nvim available
local function set_project_pwd(path)
  if project and project.set_pwd then
    pcall(project.set_pwd, path, "snacks")
  else
    vim.cmd("tcd " .. vim.fn.fnameescape(path))
  end
end

-- Work directory picker (replacement for search_work_dirs)
local function work_dirs(workpath)
  if not workpath or workpath == "" then
    vim.notify("WORKPATH not set", vim.log.levels.WARN)
    return
  end
  local handle = io.popen("cd '" .. workpath .. "' && eza -L 1 -D -s modified -1 -r 2>/dev/null")
  if not handle then
    vim.notify("Failed to list work dirs", vim.log.levels.ERROR)
    return
  end
  local result = handle:read("*a")
  handle:close()
  local dirs = {}
  for line in result:gmatch("[^\r\n]+") do
    if line ~= "" then
      table.insert(dirs, line)
    end
  end
  if #dirs == 0 then
    vim.notify("No directories found in " .. workpath, vim.log.levels.INFO)
    return
  end
  local items = {}
  for _, d in ipairs(dirs) do
    table.insert(items, { text = d, file = workpath .. "/" .. d })
  end
  require("snacks").picker.pick({
    source = "workdirs",
    items = items,
    title = "Work Dirs",
    format = function(item)
      return { { item.text } }
    end,
    confirm = function(picker, item)
      picker:close()
      if not item then
        return
      end
      local path = workpath .. "/" .. item.text
      set_project_pwd(path)
      vim.schedule(function()
        require("snacks").picker.files({ cwd = path, hidden = true, follow = true })
      end)
    end,
  })
end

function M.search_work_dirs_main()
  work_dirs(vim.env.WORKPATH)
end

function M.search_work_dirs_alt()
  work_dirs(vim.env.WORKPATH_ALT)
end

-- Parse git worktree list (porcelain) into table
local function parse_worktrees(output)
  local worktrees = {}
  local current = {}
  for line in output:gmatch("[^\r\n]+") do
    if line:match("^worktree ") then
      if next(current) then
        table.insert(worktrees, current)
      end
      current = { path = line:sub(#"worktree " + 1) }
    elseif line:match("^branch ") then
      current.branch = line:sub(#"branch " + 1):gsub("refs/heads/", "")
    elseif line:match("^HEAD ") then
      current.head = line:sub(#"HEAD " + 1)
    elseif line:match("^bare$") then
      current.bare = true
    end
  end
  if next(current) then
    table.insert(worktrees, current)
  end
  return worktrees
end

-- List git worktrees with actions: open (default), delete (<C-d>)
function M.git_worktrees()
  -- ensure we are inside a git repo
  local handle = io.popen("git rev-parse --is-inside-work-tree 2>/dev/null")
  if not handle then
    vim.notify("Not a git repo", vim.log.levels.WARN)
    return
  end
  local inside = handle:read("*l") or ""
  handle:close()
  if inside ~= "true" then
    vim.notify("Not inside a git repository", vim.log.levels.WARN)
    return
  end

  local list = io.popen("git worktree list --porcelain 2>/dev/null")
  if not list then
    vim.notify("Failed to list git worktrees", vim.log.levels.ERROR)
    return
  end
  local output = list:read("*a")
  list:close()
  local worktrees = parse_worktrees(output)
  if #worktrees == 0 then
    vim.notify("No worktrees found", vim.log.levels.INFO)
    return
  end

  local items = {}
  local cwd = vim.loop.cwd()
  for _, wt in ipairs(worktrees) do
    local text = wt.path
    if wt.branch then
      text = text .. " (" .. wt.branch .. ")"
    end
    if wt.path == cwd then
      text = "* " .. text
    end
    table.insert(items, { text = text, value = wt })
  end

  require("snacks").picker.pick({
    title = "Git Worktrees",
    source = "git_worktrees",
    items = items,
    format = function(item)
      return { { item.text } }
    end,
    confirm = function(picker, item)
      picker:close()
      if not item or not item.value then
        return
      end
      local path = item.value.path
      set_project_pwd(path)
      vim.notify("Switched to worktree: " .. path)
    end,
    keymaps = {
      ["<C-d>"] = { -- delete worktree
        desc = "Remove worktree",
        action = function(picker)
          local sel = picker:selected_item() or picker.items[picker.cursor] -- fallback
          if not sel or not sel.value then
            return
          end
          local path = sel.value.path
          if path == vim.loop.cwd() then
            vim.notify("Cannot remove current worktree", vim.log.levels.WARN)
            return
          end
          local confirm = vim.fn.input("Remove worktree " .. path .. "? (y/N) ")
          if confirm:lower() == "y" then
            local cmd = "git worktree remove '" .. path .. "' 2>&1"
            local r = io.popen(cmd)
            local res = r and r:read("*a") or ""
            if r then
              r:close()
            end
            if res ~= "" then
              vim.notify(res, vim.log.levels.INFO)
            else
              vim.notify("Removed worktree: " .. path)
            end
            vim.schedule(function()
              M.git_worktrees()
            end)
          end
        end,
      },
    },
  })
end

-- Create a new worktree: prompts for branch & base
function M.git_worktree_create()
  local branch = vim.fn.input("New branch name: ")
  if branch == "" then
    return
  end
  local base = vim.fn.input("Base branch (default: main): ")
  if base == "" then
    base = "main"
  end
  local root_handle = io.popen("git rev-parse --show-toplevel 2>/dev/null")
  if not root_handle then
    vim.notify("Not a git repo", vim.log.levels.WARN)
    return
  end
  local root = (root_handle:read("*l") or "."):gsub("\n", "")
  root_handle:close()
  local path = root .. "/" .. branch
  local cmd = string.format("git worktree add -b %s '%s' %s 2>&1", branch, path, base)
  local proc = io.popen(cmd)
  local res = proc and proc:read("*a") or ""
  if proc then
    proc:close()
  end
  if res ~= "" then
    vim.notify(res, vim.log.levels.INFO)
  end
  local ok = vim.loop.fs_stat(path)
  if ok then
    set_project_pwd(path)
    vim.notify("Created & switched to worktree: " .. path)
  end
end

return M
