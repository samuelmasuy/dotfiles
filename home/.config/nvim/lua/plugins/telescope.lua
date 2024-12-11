return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
      {
        "LennyPhoenix/project.nvim", -- instead of ahmedkhalf/project.nvim, -- auto cwd in root git repo
        branch = "fix-get_clients",
        config = function()
          require("project_nvim").setup({
            -- manual_mode = true,
          })
        end,
      },
    },
    cmd = "Telescope",
    keys = {
      {
        "<leader>t",
        function()
          vim.cmd("Telescope")
        end,
        desc = "[t]elescope",
      },
      -- search
      {
        "<C-p>",
        require("sam.telescope").search_files,
        desc = "Search Files",
      },
      {
        "<leader><leader>",
        require("telescope.builtin").git_files,
        desc = "Search Git files",
      },
      {
        "<leader>z",
        require("sam.telescope").search_configs,
        desc = "Config[z]",
      },
      {
        "<leader>j",
        require("sam.telescope").search_work_dirs,
        desc = "Work dirs",
      },
      {
        "<leader>?",
        require("telescope.builtin").oldfiles,
        desc = "[?] Find recently opened files",
      },
      {
        "<leader>sg",
        require("sam.telescope").live_multigrep,
        desc = "[S]earch by [G]rep",
      },
      {
        "<leader>e",
        require("sam.telescope").edit_neovim,
        desc = "[e]dit Neovim configs",
      },
      -- utils
      {
        "<leader>co",
        require("telescope.builtin").colorscheme,
        desc = "[c]olorscheme",
      },
      {
        "<leader><CR>",
        require("telescope.builtin").buffers,
        desc = "[<CR>] Find existing buffers",
      },
      {
        "<leader>m",
        require("telescope.builtin").keymaps,
        desc = "Key[m]aps",
      },
      {
        "<leader><space>",
        function()
          require("telescope").extensions.projects.projects()
        end,
        desc = "[ ] Search projects",
      },
      {
        "<leader>sh",
        require("telescope.builtin").help_tags,
        desc = "[S]earch [H]elp",
      },
      {
        "<leader>sw",
        require("telescope.builtin").grep_string,
        desc = "[S]earch current [W]ord",
      },
      {
        "<leader>sd",
        require("telescope.builtin").diagnostics,
        desc = "[S]earch [D]iagnostics",
      },
      -- Git worktree
      {
        "<leader>sw",
        require("telescope").extensions.git_worktree.git_worktrees,
        desc = "[S]earch Git [W]orktrees",
        noremap = true,
        silent = true,
      },

      {
        "<leader>wt",
        require("telescope").extensions.git_worktree.create_git_worktree,
        desc = "Create Git [W]orktree",
        noremap = true,
        silent = true,
      },
    },
    config = function()
      local actions = require("telescope.actions")

      require("telescope").load_extension("fzf")
      require("telescope").load_extension("projects")
      require("telescope").load_extension("git_worktree")

      require("telescope").setup({
        defaults = {
          prompt_prefix = "❯ ",
          path_display = { "smart" },
          color_devicons = true,

          file_previewer = require("telescope.previewers").vim_buffer_cat.new,
          grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
          qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

          mappings = {
            n = {
              ["<esc>"] = actions.close,
            },
            i = {
              ["<C-x>"] = false,
              ["<C-q>"] = actions.smart_send_to_qflist,
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
          },
        },
      })
    end,
  },
}
