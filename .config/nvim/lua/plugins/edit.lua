return {
  {
    "godlygeek/tabular", -- Quickly align text by pattern :'<,'>Tabularize /:
    cmd = "Tabularize",
  },
  {
    "numToStr/Comment.nvim", -- commenting with e.g. `gcc` or `gcip`
    event = "VeryLazy",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "tpope/vim-repeat", -- Repeat actions better
    event = "InsertEnter",
  },
  "tpope/vim-abolish",    -- Camel case, snake crc
  {
    "tpope/vim-surround", -- To change surrounding quote: cs(' ;tag cst<th> ;to add quote ysW'
    event = "InsertEnter",
  },
  {
    "ap/vim-css-color",
  },
  -- {
  -- 	"tpope/vim-unimpaired",
  -- 	event = "VeryLazy",
  -- },
  -- 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
}
