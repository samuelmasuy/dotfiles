return {
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("hardtime").setup({
        max_count = 6,
        max_time = 800,
        allow_different_key = true,
        restricted_keys = {
          ["<Left>"] = {},
          ["<Right>"] = {},
          ["<Up>"] = {},
          ["<Down>"] = {},
          ["-"] = {},
          -- ["h"] = {},
          -- ["j"] = {},
          -- ["k"] = {},
          -- ["l"] = {},
          ["<C-P>"] = {},
        },
        disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "minifiles" },
      })
    end,
  },
}
