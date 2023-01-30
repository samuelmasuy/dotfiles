return {
	{
		"godlygeek/tabular", -- Quickly align text by pattern :'<,'>Tabularize /:
		cmd = "Tabularize",
	},
	{
		"numToStr/Comment.nvim", -- commenting with e.g. `gcc` or `gcip`
		config = function()
			require("Comment").setup()
		end,
	},
	"tpope/vim-repeat", -- Repeat actions better
	"tpope/vim-abolish", -- Camel case, snake crc
	"tpope/vim-surround", -- To change surrounding quote: cs(' ;tag cst<th> ;to add quote ysW'
	"tpope/vim-unimpaired",
	-- 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
}
