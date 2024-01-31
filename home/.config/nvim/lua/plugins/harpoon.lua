return {
  "ThePrimeagen/harpoon",
  opts = {
    settings = {
      sync_on_ui_close = true,
      save_on_toggle = true,
    },
  },
  keys = {
    {
      "<leader>h",
      function()
        require("harpoon"):list():append()
      end,
      mode = { "n", "x" },
      desc = "[h]arpoon [a]ppend",
    },
    {
      "<leader>hl",
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      mode = { "n", "x" },
      desc = "[h]arpoon [l]ist",
    },
    {
      "]a",
      function()
        require("harpoon"):list():next({
          ui_nav_wrap = true,
        })
      end,
      mode = { "n", "x" },
      desc = "Next harpoon mark",
    },
    {
      "[a",
      function()
        require("harpoon"):list():prev({
          ui_nav_wrap = true,
        })
      end,
      mode = { "n", "x" },
      desc = "Previous harpoon mark",
    },
  },
  dependencies = "nvim-lua/plenary.nvim",
  branch = "harpoon2",
}
