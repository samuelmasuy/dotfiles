local actions = require('telescope.actions')
local themes = require('telescope.themes')
local action_state = require "telescope.actions.state"

require('telescope').load_extension('fzf')

require('telescope').setup {
  defaults = {
    prompt_prefix = "❯ ",
    path_display = { "smart" },
    color_devicons = true,

    file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

    mappings = {
      n = {
        ["<esc>"] = actions.close,
      },
      i = {
        ["<C-x>"] = false,
        ["<C-q>"] = actions.send_to_qflist,
      },
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  }
}


local M = {}
M.search_configs = function()
  require('telescope.builtin').find_files({
    hidden = true,
    follow = true,
    prompt_title = '< Config >',
    cwd = '$XDG_CONFIG_HOME/',
  })
end

M.search_files = function()
  require('telescope.builtin').find_files({
    find_command = { "fd", "--type", "f", "--exclude", ".git", "--exclude", "node_modules" },
    hidden = true,
    follow = true,
  })
end


M.search_work_dirs = function()
  require('telescope.builtin').find_files({
    find_command = { "exa", "-L", "1", "-D", "-s", "modified", "-1", "-r" },
    prompt_title = '< Work Dirs >',
    cwd = '$WORKPATH',
  })
end

M.lsp_code_actions = function()
  local opts = themes.get_dropdown {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }

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
