return {
  {
    "folke/snacks.nvim",
    enabled = true,
    priority = 1000,
    lazy = false,
    dependencies = {
      { "nvim-mini/mini.icons", version = "*", opts = {} },
    },
    keys = {
      {
        "<leader>p",
        function()
          Snacks.picker.pickers()
        end,
        desc = "All Pickers",
      },
      {
        "<C-p>",
        function()
          require("snacks").picker.files({
            hidden = true,
            follow = true,
            args = { "--type", "f", "--exclude", ".git", "--exclude", "node_modules" },
          })
        end,
        desc = "Search Files",
      },
      {
        "<leader><leader>",
        function()
          Snacks.picker.git_files({ show_empty = true })
        end,
        desc = "Search Git files",
      },
      {
        "<leader>z",
        function()
          require("sam.snacks").search_configs()
        end,
        desc = "Config[z]",
      },
      {
        "<leader>j",
        function()
          require("sam.snacks").search_work_dirs_main()
        end,
        desc = "Work dirs",
      },
      {
        "<leader>a",
        function()
          require("sam.snacks").search_work_dirs_alt()
        end,
        desc = "Work alt dirs",
      },
      {
        "<leader>?",
        function()
          Snacks.picker.recent({})
        end,
        desc = "Recent files",
      },
      {
        "<leader>sg",
        function()
          Snacks.picker.grep({ live = true, hidden = true })
        end,
        desc = "[S]earch by [G]rep",
      },
      {
        "<leader>e",
        function()
          Snacks.picker.files({
            cwd = vim.fn.stdpath("config"),
            hidden = true,
            follow = true,
            prompt = "~ nvim ~",
            layout = "telescope",
          })
        end,
        desc = "[e]dit Neovim configs",
      },
      {
        "<leader><CR>",
        function()
          require("snacks").picker.buffers({})
        end,
        desc = "Buffers",
      },
      {
        "<leader><space>",
        function()
          Snacks.picker.projects()
        end,
        desc = "Projects",
      },
      {
        "<leader>sh",
        function()
          Snacks.picker.help()
        end,
        desc = "[S]earch [H]elp",
      },
      {
        "<leader>sw",
        function()
          Snacks.picker.grep_word({})
        end,
        desc = "[S]earch current [W]ord",
      },
      {
        "<leader>sd",
        function()
          Snacks.picker.diagnostics()
        end,
        desc = "[S]earch [D]iagnostics",
      },
      {
        "<leader>stw",
        function()
          require("sam.snacks").git_worktrees()
        end,
        desc = "[S]earch Gi[t] [W]orktrees",
      },
      {
        "<leader>wt",
        function()
          require("sam.snacks").git_worktree_create()
        end,
        desc = "Create Git [W]orktree",
      },
      {
        "<leader>gb",
        function()
          Snacks.picker.git_branches()
        end,
        desc = "Git [B]ranches",
      },
      {
        "<leader>gs",
        function()
          Snacks.picker.git_status()
        end,
        desc = "Git [S]tatus",
      },
    },
    opts = {
      dashboard = {
        enabled = true,
        width = 80,
        row = nil,
        col = nil,
        pane_gap = 1,
        preset = {
          pick = "snacks",
          keys = {
            { icon = " ", key = "e", desc = "New file", action = ":ene | startinsert" },
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('recent')" },
            { icon = "󰒲 ", key = "u", desc = "Update plugins", action = ":Lazy sync" },
          },
        },
        sections = {
          {
            section = "terminal",
            cmd = "curl -s 'wttr.in/?0AQ'",
            padding = 1,
            allign = "center",
            height = 5,
          },
          { section = "keys",         gap = 0,                              padding = 1 },
          { title = "MRU",            padding = 0 },
          { section = "recent_files", limit = 4,                            padding = 1 },
          { title = "MRU ",           file = vim.fn.fnamemodify(".", ":~"), padding = 0 },
          { section = "recent_files", cwd = true,                           limit = 4,  padding = 1 },
          { title = "Projects",       section = "projects",                 limit = 4,  padding = 1 },
        },
      },
      picker = {
        prompt = "❯ ",
        layout = {
          preset = function()
            return vim.o.columns >= 120 and "telescope" or "vertical"
          end,
        },
        matcher = { fuzzy = true, smartcase = true, ignorecase = true },
        ui_select = true,
        sources = {
          explorer = { layout = { preset = "sidebar" } },
        },
        actions = {},
      },
    },
  },
}
