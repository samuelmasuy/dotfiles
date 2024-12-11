local actions = require("telescope.actions")
local themes = require("telescope.themes")
local action_state = require("telescope.actions.state")
local project = require("project_nvim.project")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values
local finders = require("telescope.finders")
local builtin = require("telescope.builtin")

local M = {}
M.search_configs = function()
  require("telescope.builtin").find_files({
    hidden = true,
    follow = true,
    prompt_title = "< Config >",
    cwd = "$XDG_CONFIG_HOME/",
  })
end

M.search_files = function()
  require("telescope.builtin").find_files({
    find_command = { "fd", "--type", "f", "--exclude", ".git", "--exclude", "node_modules" },
    hidden = true,
    follow = true,
  })
end

M.live_multigrep = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  local finder = finders.new_async_job {
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end

      local pieces = vim.split(prompt, "  ")
      local args = { "rg" }
      if pieces[1] then
        table.insert(args, "-e")
        table.insert(args, pieces[1])
      end
      if pieces[2] then
        table.insert(args, "-g")
        table.insert(args, pieces[2])
      end

      ---@diagnostic disable-next-line: deprecated
      return vim.tbl_flatten {
        args,
        { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
      }
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  }

  pickers.new(opts, {
    debounce = 100,
    prompt_title = "Multi Grep",
    finder = finder,
    previewer = conf.grep_previewer(opts),
    sorter = require("telescope.sorters").empty(),
  }):find()
end

local function change_working_directory(prompt_bufnr, _)
  local selected_entry = action_state.get_selected_entry()
  if selected_entry == nil then
    actions.close(prompt_bufnr)
    return
  end
  local project_path = selected_entry.path
  actions.close(prompt_bufnr)
  local cd_successful = project.set_pwd(project_path, "telescope")
  return project_path, cd_successful
end

local function find_project_files(prompt_bufnr)
  local project_path, cd_successful = change_working_directory(prompt_bufnr, true)
  local opt = {
    cwd = project_path,
    hidden = true,
    mode = "insert",
  }
  if cd_successful then
    builtin.find_files(opt)
  end
end

M.search_work_dirs = function()
  local opts = {
    find_command = { "eza", "-L", "1", "-D", "-s", "modified", "-1", "-r" },
    prompt_title = "< Work Dirs >",
    cwd = "$WORKPATH",
  }
  opts.cwd = vim.fn.expand(opts.cwd)

  opts.entry_maker = opts.entry_maker or make_entry.gen_from_file(opts)

  pickers
      .new(opts, {
        finder = finders.new_oneshot_job(opts.find_command, opts),
        previewer = conf.file_previewer(opts),
        sorter = conf.file_sorter(opts),
        attach_mappings = function(prompt_bufnr, _)
          local on_project_selected = function()
            find_project_files(prompt_bufnr)
          end
          actions.select_default:replace(on_project_selected)
          return true
        end,
      })
      :find()

  -- require("telescope.builtin").find_files({
  -- 	find_command = { "exa", "-L", "1", "-D", "-s", "modified", "-1", "-r" },
  -- 	prompt_title = "< Work Dirs >",
  -- 	cwd = "$WORKPATH",
  -- })
end

M.lsp_code_actions = function()
  local opts = themes.get_dropdown({
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  })

  require("telescope.builtin").lsp_code_actions(opts)
end

local set_prompt_to_entry_value = function(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  if not entry or not type(entry) == "table" then
    return
  end

  action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end

function M.edit_neovim()
  local opts_with_preview, opts_without_preview

  opts_with_preview = {
    prompt_title = "~ nvim ~",
    follow = true,
    shorten_path = false,
    cwd = "$XDG_CONFIG_HOME/nvim",

    layout_strategy = "flex",
    layout_config = {
      width = 0.9,
      height = 0.8,

      horizontal = {
        width = { padding = 0.15 },
      },
      vertical = {
        preview_height = 0.75,
      },
    },

    mappings = {
      i = {
        ["<C-y>"] = false,
      },
    },

    attach_mappings = function(_, map)
      map("i", "<c-y>", set_prompt_to_entry_value)
      map("i", "<M-c>", function(prompt_bufnr)
        actions.close(prompt_bufnr)
        vim.schedule(function()
          require("telescope.builtin").find_files(opts_without_preview)
        end)
      end)

      return true
    end,
  }

  opts_without_preview = vim.deepcopy(opts_with_preview)
  opts_without_preview.previewer = false

  require("telescope.builtin").find_files(opts_with_preview)
end

return M
