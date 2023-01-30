return {
	"godlygeek/tabular", -- Quickly align text by pattern :'<,'>Tabularize /:
	{
		"numToStr/Comment.nvim", -- "gc" to comment visual regions/lines
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
