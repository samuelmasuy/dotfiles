return {
	-- colorschemes
	-- 'joshdick/onedark.vim',
	-- 'ful1e5/onedark.nvim',
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
	{
		"navarasu/onedark.nvim",
		config = function()
			local opt = vim.opt
			local cmd = vim.cmd

			opt.background = "dark"
			opt.termguicolors = true

			-- Colorscheme
			-- cmd [[colorscheme material]]
			-- cmd [[colorscheme one-nvim]]
			-- cmd [[colorscheme tokyonight]]
			-- cmd [[colorscheme gruvbox]]

			require("onedark").setup({
				style = "dark",
				diagnostics = {
					undercurl = true, -- use undercurl instead of underline for diagnostics
				},
			})
			require("onedark").load()

			-- Colorize the 100th column if goes over.
			cmd("highlight ColorColumn ctermbg=magenta")
			vim.fn.matchadd("ColorColumn", "\\%101v", 100)

			-- undercurl
			cmd([[
        hi SpellBad     gui=undercurl term=undercurl cterm=undercurl
      ]])

			-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			-- for type, icon in pairs(signs) do
			-- 	local hl = "DiagnosticSign" .. type
			-- 	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			-- end
			vim.diagnostic.config({
				virtual_text = {
					-- source = "always",  -- Or "if_many"
					-- prefix = "●", -- Could be '■', '▎', 'x'
				},
				severity_sort = true,
				float = {
					source = "always",
					border = "rounded",
					-- source = "always", -- Or "if_many"
				},
			})
		end,
	},
}
