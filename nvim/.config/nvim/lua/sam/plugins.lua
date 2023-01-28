return require("lazy").setup({
	{
		-- 'tjdevries/astronauta.nvim', -- Lua ftplugins & lua plugin
		"nvim-lua/plenary.nvim", -- lua utils
	},
	-- Speed up loading Lua modules in Neovim to improve startup time.
	-- "lewis6991/impatient.nvim",

	-- LSP
	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Useful status updates for LSP
			-- "j-hui/fidget.nvim",
		},
	},
	-- when lsp format does not work
	"jose-elias-alvarez/null-ls.nvim",
	-- 'nvim-lua/lsp_extensions.nvim',

	-- Completion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua", -- for vim.api
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-cmdline",
			"lukas-reineke/cmp-rg",
			"andersevenrud/cmp-tmux",
			-- "L3MON4D3/LuaSnip",
			-- "rafamadriz/friendly-snippets",
			-- "saadparwaiz1/cmp_luasnip",
		},
	},

	-- TREE SITTER:
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	},

	-- Text Maniuplation
	"godlygeek/tabular", -- Quickly align text by pattern :'<,'>Tabularize /:
	"numToStr/Comment.nvim", -- "gc" to comment visual regions/lines
	"tpope/vim-repeat", -- Repeat actions better
	"tpope/vim-abolish", -- Camel case, snake crc
	"tpope/vim-surround", -- To change surrounding quote: cs(' ;tag cst<th> ;to add quote ysW'
	"monaqa/dial.nvim", -- Better increment/decrement
	"tpope/vim-unimpaired",
	-- 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically

	-- GIT
	"tpope/vim-fugitive", -- awesome git
	"tpope/vim-rhubarb", -- Companion of fugitive for integration with Github

	-- search
	{
		"ahmedkhalf/project.nvim", -- auto cwd in root git repo
		config = function()
			require("project_nvim").setup({
				-- manual_mode = true,
			})
		end,
	},

	"junegunn/vim-peekaboo", -- what's in @ and \"
	{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },

	-- {
	--   "nvim-telescope/telescope-frecency.nvim",
	--   config = function()
	--     require"telescope".load_extension("frecency")
	--   end,
	--   dependencies = {"tami5/sqlite.lua"}
	-- }

	-- Syntax
	"ajorgensen/vim-markdown-toc",
	{ "modille/groovy.vim", ft = { "groovy", "Jenkinsfile" } },
	{ "vim-scripts/haproxy", ft = "haproxy*" },
	{ "tjdevries/nlua.nvim" },
	"towolf/vim-helm",
	"chr4/nginx.vim",
	"mustache/vim-mustache-handlebars",

	"justinmk/vim-syntax-extra",
	-- all go
	-- {
	--   'crispgm/nvim-go',
	--   build = ':GoInstallBinaries',
	--   dependencies = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' }
	--   -- ft = 'go',
	-- },
	-- 'ray-x/go.nvim',
	-- { "buoto/gotests-vim", ft = "go", build = ":!go install github.com/cweill/gotests/..." },

	-- express yourself well
	{ "rhysd/vim-grammarous", ft = { "text", "markdown" } },
	"ron89/thesaurus_query.vim", -- synonym <leader>cs
	{ "chrisbra/unicode.vim", ft = { "text", "markdown" } },

	-- colorschemes
	-- 'joshdick/onedark.vim',
	-- 'ful1e5/onedark.nvim',
	{ "navarasu/onedark.nvim" },
	-- {
	--   'rose-pine/neovim',
	--   name = 'rose-pine',
	-- },
	-- {
	--   'npxbr/gruvbox.nvim',
	--   dependencies = {
	--     'rktjmp/lush.nvim',
	--   }
	-- },
	-- 'Th3Whit3Wolf/one-nvim'
	-- 'yashguptaz/calvera-dark.nvim'
	-- 'marko-cerovac/material.nvim'
	-- "folke/tokyonight.nvim"
	-- 'tjdevries/colorbuddy.vim'
	-- 'tjdevries/gruvbuddy.nvim'

	-- line
	"nvim-lualine/lualine.nvim", -- Fancier statusline

	-- utils
	-- "kyazdani42/nvim-web-devicons"
	-- "mhinz/vim-startify" -- Startup Screen

	-- Startup screen
	{
		"goolord/alpha-nvim",
		dependencies = {
			"kyazdani42/nvim-web-devicons",
		},
		-- 	config = function()
		-- 		require("alpha").setup(require("alpha.themes.startify").config)
		-- 	end,
	},

	-- "tpope/vim-vinegar" -- Enhance netrw
	"tpope/vim-eunuch", -- Adds Unix commands to vim.
	-- 'justinmk/vim-dirvish' -- minimalist directory viewer -
	-- 'Valloric/MatchTagAlways'
	-- 'Valloric/ListToggle' -- quick*fix* *l*ocation
	"vim-scripts/DirDiff.vim", -- :DirDiff <A:Src Directory> <B:Src Directory>
	"bronson/vim-trailing-whitespace", -- show them
	-- 'vim-scripts/visSum.vim' -- <leader>su
	-- 'vim-scripts/VisIncr' -- Increment all the things v-select jan\njan\njan :IM.
	-- 'mbbill/undotree'
	-- 'machakann/vim-highlightedyank'
	"christoomey/vim-sort-motion", -- sort lines characters arguments etc
	-- 'fmoralesc/vim-tutor-mode'
	-- 'janko/vim-test' -- let test#strategy = 'neovim'
	"christianrondeau/vim-base64", -- <leader>atob / btoa

	-- all hashicorp goodies
	{
		-- "hashivim/vim-packer",
		"hashivim/vim-terraform",
		-- "hashivim/vim-vaultproject",
	},

	-- tmux
	"tmux-plugins/vim-tmux", -- tmux.conf
	"christoomey/vim-tmux-navigator",
})
