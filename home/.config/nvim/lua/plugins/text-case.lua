return {
  "johmsalas/text-case.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("textcase").setup({})
    require("telescope").load_extension("textcase")
  end,
  keys = {
    "ga", -- Default invocation prefix
    { "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" },
    { "gan" },
    { "gac" },
    { "gas" },
    { "gad" },
    { "gap" },
    { "gau" },
    { "gal" },
    { "gaN" },
    { "gaC" },
    { "gaS" },
    { "gaD" },
    { "gaP" },
    { "gaU" },
    { "gaL" },
    { "gon" },
    { "goc" },
    { "gos" },
    { "god" },
    { "gop" },
    { "gou" },
    { "gol" },
  },
  cmd = {
    -- NOTE: The Subs command name can be customized via the option "substitude_command_name"
    "Subs",
  },
}
