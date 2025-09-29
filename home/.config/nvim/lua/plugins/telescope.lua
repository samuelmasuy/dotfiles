return {
  {
    "DrKJeff16/project.nvim",
    -- name = "project_nvim",
    cond = vim.fn.has("nvim-0.11") == 1, -- RECOMMENDED
    opts = {
      fzf_lua = {
        enabled = false,
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = vim.fn.executable("make") == 1,
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
        function()
          require("sam.telescope").search_files()
        end,
        desc = "Search Files",
      },
      {
        "<leader><leader>",
        function()
          require("telescope.builtin").git_files()
        end,
        desc = "Search Git files",
      },
      {
        "<leader>z",
        function()
          require("sam.telescope").search_configs()
        end,
        desc = "Config[z]",
      },
      {
        "<leader>j",
        function()
          require("sam.telescope").search_work_dirs(vim.fn.getenv("WORKPATH"))
        end,
        desc = "Work dirs",
      },
      {
        "<leader>a",
        function()
          require("sam.telescope").search_work_dirs(vim.fn.getenv("WORKPATH_ALT"))
        end,
        desc = "Work alt dirs",
      },
      {
        "<leader>?",
        function()
          require("telescope.builtin").oldfiles()
        end,
        desc = "[?] Find recently opened files",
      },
      {
        "<leader>sg",
        function()
          require("sam.telescope").live_multigrep()
        end,
        desc = "[S]earch by [G]rep",
      },
      {
        "<leader>e",
        function()
          require("sam.telescope").edit_neovim()
        end,
        desc = "[e]dit Neovim configs",
      },
      -- utils
      {
        "<leader><CR>",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "[<CR>] Find existing buffers",
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
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "[S]earch [H]elp",
      },
      {
        "<leader>sw",
        function()
          require("telescope.builtin").grep_string()
        end,
        desc = "[S]earch current [W]ord",
      },
      {
        "<leader>sd",
        function()
          require("telescope.builtin").diagnostics()
        end,
        desc = "[S]earch [D]iagnostics",
      },
      -- Git worktree
      {
        "<leader>sw",
        function()
          require("telescope").extensions.git_worktree.git_worktrees()
        end,
        desc = "[S]earch Git [W]orktrees",
        noremap = true,
        silent = true,
      },

      {
        "<leader>wt",
        function()
          require("telescope").extensions.git_worktree.create_git_worktree()
        end,
        desc = "Create Git [W]orktree",
        noremap = true,
        silent = true,
      },
    },
    config = function()
      local actions = require("telescope.actions")

      vim.api.nvim_create_user_command("Color", function()
        require("telescope.builtin").colorscheme()
      end, { desc = "Pick a colorscheme" })

      require("telescope").load_extension("fzf")

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
