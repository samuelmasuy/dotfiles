return {
  "olimorris/codecompanion.nvim",
  opts = {
    strategies = {
      chat = {
        adapter = {
          name = "copilot",
          -- model = "claude-3.7-sonnet",
          model = "claude-sonnet-4-20250514",
        },
      },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "echasnovski/mini.diff",
      config = function()
        local diff = require("mini.diff")
        diff.setup({
          -- Disabled by default
          source = diff.gen_source.none(),
        })
      end,
    },
  },
  keys = {
    { "<leader>cc", "<cmd>CodeCompanionChat toggle<cr>", desc = "Chat" },
    { "<leader>ca", "<cmd>CodeCompanionActions<cr>",     desc = "Companion Actions" },
  },
}
