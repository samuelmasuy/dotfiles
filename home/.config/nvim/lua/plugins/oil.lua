return {
  {
    "stevearc/oil.nvim",
    -- lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        columns = { "icon" },
        keymaps = {
          ["<C-h>"] = false,
          ["l"] = "actions.select",
          ["h"] = "actions.parent",
          ["q"] = "actions.close",
        },
        view_options = {
          show_hidden = true,
        },
      })

      -- Open parent directory in current window
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
      -- Open parent directory in floating window
      -- vim.keymap.set("n", "<leader>-", require("oil").toggle_float)
    end,
  },
}
