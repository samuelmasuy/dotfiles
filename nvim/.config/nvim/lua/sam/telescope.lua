local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
    prompt_prefix = '❯ ',
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

require('telescope').load_extension('fzf')

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

return M
