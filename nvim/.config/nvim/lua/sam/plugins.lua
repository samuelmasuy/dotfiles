vim.cmd([[packadd packer.nvim]])
vim.cmd([[packadd vimball]])

vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])

return require("packer").startup({
	function(use)
		use("wbthomason/packer.nvim")

		use({
			-- 'tjdevries/astronauta.nvim', -- Lua ftplugins & lua plugin
			"nvim-lua/plenary.nvim", -- lua utils
		})
		-- Speed up loading Lua modules in Neovim to improve startup time.
		use("lewis6991/impatient.nvim")

		-- LSP
		-- use {  'VonHeikemen/lsp-zero.nvim',
		use({ -- LSP Configuration & Plugins
			"neovim/nvim-lspconfig",
			requires = {
				-- Automatically install LSPs to stdpath for neovim
				"williamboman/mason.nvim",
				"williamboman/mason-lspconfig.nvim",

				-- Useful status updates for LSP
				-- "j-hui/fidget.nvim",
			},
		})
		-- when lsp format does not work
		use({ "jose-elias-alvarez/null-ls.nvim" })
		-- use 'nvim-lua/lsp_extensions.nvim'

		-- Completion
		use({
			"hrsh7th/nvim-cmp",
			requires = {
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
		})

		-- TREE SITTER:
		use({ -- Highlight, edit, and navigate code
			"nvim-treesitter/nvim-treesitter",
			run = function()
				pcall(require("nvim-treesitter.install").update({ with_sync = true }))
			end,
		})
		use({ -- Additional text objects via treesitter
			"nvim-treesitter/nvim-treesitter-textobjects",
			after = "nvim-treesitter",
		})

		-- Text Maniuplation
		use("godlygeek/tabular") -- Quickly align text by pattern :'<,'>Tabularize /:
		use("numToStr/Comment.nvim") -- "gc" to comment visual regions/lines
		use("tpope/vim-repeat") -- Repeat actions better
		use("tpope/vim-abolish") -- Camel case, snake crc
		use("tpope/vim-surround") -- To change surrounding quote: cs(' ;tag cst<th> ;to add quote ysW'
		use("monaqa/dial.nvim") -- Better increment/decrement
		use("tpope/vim-unimpaired")
		-- use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically

		-- GIT
		use("tpope/vim-fugitive") -- awesome git
		use("tpope/vim-rhubarb") -- Companion of fugitive for integration with Github

		-- search
		use({
			"ahmedkhalf/project.nvim", -- auto cwd in root git repo
			config = function()
				require("project_nvim").setup({
					-- manual_mode = true,
				})
			end,
		})

		use("junegunn/vim-peekaboo") -- what's in @ and \"
		use({ "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { "nvim-lua/plenary.nvim" } })
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable("make") == 1 })

		-- use {
		--   "nvim-telescope/telescope-frecency.nvim",
		--   config = function()
		--     require"telescope".load_extension("frecency")
		--   end,
		--   requires = {"tami5/sqlite.lua"}
		-- }

		-- Syntax
		-- use({ "tpope/vim-markdown", ft = { "markdown", "md" } })
		use("ajorgensen/vim-markdown-toc")
		-- use({ "pangloss/vim-javascript", ft = { "javascript", "typescript" } })
		-- use({ "leafgarland/typescript-vim", ft = "typescript" })
		use({ "modille/groovy.vim", ft = { "groovy", "Jenkinsfile" } })
		use({ "vim-scripts/haproxy", ft = "haproxy*" })
		-- use { 'cespare/vim-toml', ft = '*.toml' }
		use({ "tjdevries/nlua.nvim" })
		-- use({ "elzr/vim-json", ft = "json" })
		use("towolf/vim-helm")
		use("chr4/nginx.vim")
		use("mustache/vim-mustache-handlebars")

		-- use 'NLKNguyen/cloudformation-syntax.vim'
		-- use { 'stephpy/vim-yaml', ft = 'yaml' }
		-- use 'mhinz/vim-rfc' -- sudo gem install nokogiri
		-- use { 'vim-scripts/rfc-syntax', ft = 'rfc' }
		use("justinmk/vim-syntax-extra")

		-- all go
		-- use {
		--   'crispgm/nvim-go',
		--   run = ':GoInstallBinaries',
		--   requires = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' }
		--   -- ft = 'go',
		-- }
		-- use 'ray-x/go.nvim'
		-- use({ "buoto/gotests-vim", ft = "go", run = ":!go install github.com/cweill/gotests/..." })

		-- express yourself well
		use({ "rhysd/vim-grammarous", ft = { "text", "markdown" } })
		use("ron89/thesaurus_query.vim") -- synonym <leader>cs
		use({ "chrisbra/unicode.vim", ft = { "text", "markdown" } })

		-- colorschemes
		-- use { 'joshdick/onedark.vim' }
		-- use 'ful1e5/onedark.nvim'
		use({ "navarasu/onedark.nvim" })
		-- use({
		--   'rose-pine/neovim',
		--   as = 'rose-pine',
		-- })
		-- use {
		--   'npxbr/gruvbox.nvim',
		--   requires = {
		--     'rktjmp/lush.nvim',
		--   }
		-- }
		-- use { 'Th3Whit3Wolf/one-nvim' }
		-- use { 'yashguptaz/calvera-dark.nvim' }
		-- use { 'marko-cerovac/material.nvim' }
		-- use({ "folke/tokyonight.nvim" })
		-- use { 'tjdevries/colorbuddy.vim' }
		-- use { 'tjdevries/gruvbuddy.nvim' }

		-- line
		use("nvim-lualine/lualine.nvim") -- Fancier statusline

		-- utils
		-- use("kyazdani42/nvim-web-devicons")
		-- use("mhinz/vim-startify") -- Startup Screen

		use({
			"goolord/alpha-nvim",
			requires = {
				"kyazdani42/nvim-web-devicons",
			},
		})

		-- use({
		-- 	"goolord/alpha-nvim",
		-- 	requires = { "kyazdani42/nvim-web-devicons" },
		-- 	config = function()
		-- 		require("alpha").setup(require("alpha.themes.startify").config)
		-- 	end,
		-- })

		-- use("tpope/vim-vinegar") -- Enhance netrw
		use("tpope/vim-eunuch") -- Adds Unix commands to vim.
		-- use 'justinmk/vim-dirvish' -- minimalist directory viewer -
		-- use 'Valloric/MatchTagAlways'
		-- use 'Valloric/ListToggle' -- quick*fix* *l*ocation
		use("vim-scripts/DirDiff.vim") -- :DirDiff <A:Src Directory> <B:Src Directory>
		use("bronson/vim-trailing-whitespace") -- show them
		-- use 'vim-scripts/visSum.vim' -- <leader>su
		-- use 'vim-scripts/VisIncr' -- Increment all the things v-select jan\njan\njan :IM.
		-- use 'mbbill/undotree'
		-- use 'machakann/vim-highlightedyank'
		use("christoomey/vim-sort-motion") -- sort lines characters arguments etc
		-- use 'fmoralesc/vim-tutor-mode'
		-- use 'janko/vim-test' -- let test#strategy = 'neovim'
		use("christianrondeau/vim-base64") -- <leader>atob / btoa

		-- all hashicorp goodies
		use({
			-- "hashivim/vim-packer",
			"hashivim/vim-terraform",
			-- "hashivim/vim-vaultproject",
		})

		-- tmux
		use("tmux-plugins/vim-tmux") -- tmux.conf
		use("christoomey/vim-tmux-navigator")
	end,

	config = {
		display = {
			-- open_fn = require('packer.util').float,
		},
	},
})
