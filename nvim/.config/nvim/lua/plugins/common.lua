return {
	{
		-- 'tjdevries/astronauta.nvim', -- Lua ftplugins & lua plugin
		"nvim-lua/plenary.nvim", -- lua utils
	},

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
	{
		"ron89/thesaurus_query.vim", -- synonym
		keys = { "<leader>cs" },
	},
	{ "chrisbra/unicode.vim", ft = { "text", "markdown" } },

	-- utils
	-- "kyazdani42/nvim-web-devicons"
	-- "mhinz/vim-startify" -- Startup Screen

	-- "tpope/vim-vinegar" -- Enhance netrw
	"tpope/vim-eunuch", -- Adds Unix commands to vim.
	-- 'justinmk/vim-dirvish' -- minimalist directory viewer -
	-- 'Valloric/MatchTagAlways'
	-- 'Valloric/ListToggle' -- quick*fix* *l*ocation
	{
		"vim-scripts/DirDiff.vim", -- :DirDiff <A:Src Directory> <B:Src Directory>
		cmd = "DirDiff",
	},

	"bronson/vim-trailing-whitespace", -- show them
	-- 'vim-scripts/visSum.vim' -- <leader>su
	-- 'vim-scripts/VisIncr' -- Increment all the things v-select jan\njan\njan :IM.
	-- 'mbbill/undotree'
	-- 'machakann/vim-highlightedyank'
	{
		"christoomey/vim-sort-motion", -- sort lines characters arguments etc
		config = function()
			vim.g.sort_motion = "gso"
			vim.g.sort_motion_lines = "gsos"
			vim.g.sort_motion_visual = "gso"
		end,
		keys = { "gso", "gsos", { "gso", mode = "v" } },
	},
	-- 'fmoralesc/vim-tutor-mode'
	-- 'janko/vim-test' -- let test#strategy = 'neovim'
	{
		"christianrondeau/vim-base64", -- <leader>atob / btoa
		keys = { "<leader>atob", "<leader>btoa" },
	},
	-- all hashicorp goodies
	{
		-- "hashivim/vim-packer",
		"hashivim/vim-terraform",

		-- "hashivim/vim-vaultproject",
	},

	-- tmux
	"tmux-plugins/vim-tmux", -- tmux.conf
	"christoomey/vim-tmux-navigator",
}
