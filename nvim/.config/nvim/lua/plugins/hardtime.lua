return {
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("hardtime").setup({
        restricted_keys = {
          ["-"] = {},
          ["j"] = {},
          ["k"] = {},
          ["<C-P>"] = {},
        },
        disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "minifiles" },
      })
    end,
  },
}
