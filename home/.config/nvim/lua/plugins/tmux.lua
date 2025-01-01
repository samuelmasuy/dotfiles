return {
  {
    "tmux-plugins/vim-tmux", -- tmux.conf
    event = "VeryLazy",
  },
  {
    "mrjones2014/smart-splits.nvim",
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
    opts = {
      disable_multiplexer_nav_when_zoomed = false,
    },
  },
  -- {
  --
  --   "alexghergh/nvim-tmux-navigation",
  --
  --   event = "BufEnter",
  --   config = function()
  --     local nvim_tmux_nav = require("nvim-tmux-navigation")
  --
  --     nvim_tmux_nav.setup({
  --       disable_when_zoomed = false, -- defaults to false
  --     })
  --
  --     vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
  --     vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
  --     vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
  --     vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
  --     vim.keymap.set("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
  --     vim.keymap.set("n", "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
  --   end,
  -- },
}
