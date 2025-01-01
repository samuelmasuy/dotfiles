return {
  "kylechui/nvim-surround",
  keys = {
    { "ys", mode = { "n", "v" } },
    { "S", mode = { "n", "v" } },
    { "ds", mode = { "n", "v" } },
    { "cs", mode = { "n", "v" } },
    { "cS", mode = { "n", "v" } },
    { "yss", mode = { "n", "v" } },
    { "yS", mode = { "n", "v" } },
    { "ySS", mode = { "n", "v" } },
  },
  config = function()
    require("nvim-surround").setup({
      -- Configuration here, or leave empty to use defaults
    })
  end,
}
