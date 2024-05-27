return {
  { "towolf/vim-helm", ft = "helm", event = "VeryLazy" },
  {
    "godlygeek/tabular", -- Quickly align text by pattern :'<,'>Tabularize /:
    cmd = "Tabularize",
  },
  {
    "tpope/vim-abolish", -- Camel case, snake crc
    event = "VeryLazy",
  },
  {
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
  },
  {
    "ap/vim-css-color",
    event = "VeryLazy",
  },
  -- {
  --   "tpope/vim-repeat", -- Repeat actions better
  --   event = "VeryLazy",
  -- },
  -- {
  -- 	"tpope/vim-unimpaired",
  -- 	event = "VeryLazy",
  -- },
  -- 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
}
