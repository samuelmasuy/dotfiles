return {
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
}
