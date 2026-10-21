return {
  {
    "tmux-plugins/vim-tmux", -- tmux.conf
    event = "VeryLazy",
  },
  {
    "smart-splits-nvim/smart-splits.nvim",
    lazy = false,
    dependencies = {
      {
        "smart-splits-nvim/backend-tmux",
        main = "smart-splits-backend-tmux",
        opts = {
          disable_nav_when_zoomed = false,
        },
      },
    },
    opts = {
      mux = {
        backend = "smart-splits-backend-tmux",
      },
    },
    keys = {
      -- window movement
      {
        "<C-h>",
        function()
          require("smart-splits").move_cursor_left()
        end,
      },
      {
        "<C-j>",
        function()
          require("smart-splits").move_cursor_down()
        end,
      },
      {
        "<C-k>",
        function()
          require("smart-splits").move_cursor_up()
        end,
      },
      {
        "<C-l>",
        function()
          require("smart-splits").move_cursor_right()
        end,
      },
      {
        "<A-h>",
        function()
          require("smart-splits").resize_left()
        end,
      },
      {
        "<A-j>",
        function()
          require("smart-splits").resize_down()
        end,
      },
      {
        "<A-k>",
        function()
          require("smart-splits").resize_up()
        end,
      },
      {
        "<A-l>",
        function()
          require("smart-splits").resize_right()
        end,
      },
    },
  },
}
