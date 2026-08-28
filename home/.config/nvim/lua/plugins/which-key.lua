return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 350,
    },
    config = function(_, opts)
      vim.o.timeout = true
      vim.o.timeoutlen = 350
      require("which-key").setup(opts)
    end,
  },
}
