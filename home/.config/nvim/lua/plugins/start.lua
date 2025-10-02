return {
  {
    "folke/snacks.nvim",
    enabled = true,
    priority = 1000,
    lazy = false,
    opts = {
      dashboard = {
        enabled = true,
        width = 80,
        row = nil,
        col = nil,
        pane_gap = 1,
        preset = {
          pick = "telescope.nvim",
          keys = {
            { icon = " ", key = "e", desc = "New file", action = ":ene | startinsert" },
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
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
          { title = "MRU",            padding = 1 },
          { section = "recent_files", limit = 4,                            padding = 1 },
          { title = "MRU ",           file = vim.fn.fnamemodify(".", ":~"), padding = 1 },
          { section = "recent_files", cwd = true,                           limit = 4,  padding = 1 },
          { section = "projects",     limit = 4,                            padding = 1 },
          -- { icon = " ",         title = "Projects", section = "projects", indent = 2, padding = 1 },
        },
      },
      styles = {
        dashboard = {
          wo = {
            colorcolumn = "",
            -- cursorcolumn = false,
            -- cursorline = false,
            -- foldmethod = "manual",
            -- list = false,
            -- number = false,
            -- relativenumber = false,
            -- sidescrolloff = 0,
            -- signcolumn = "no",
            -- spell = false,
            -- statuscolumn = "",
            -- statusline = "",
            -- winbar = "",
            -- winhighlight = "Normal:SnacksDashboardNormal,NormalFloat:SnacksDashboardNormal",
            -- wrap = false,
          },
        },
      },
    },
  },
}
