return {
	-- Syntax
	{ "ajorgensen/vim-markdown-toc", ft = "markdown" },
	{ "modille/groovy.vim", ft = { "groovy", "Jenkinsfile" } },
	{ "vim-scripts/haproxy", ft = "haproxy*" },
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
