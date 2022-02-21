local opt = vim.opt
-- local cmd = vim.cmd

opt.background = 'dark'
opt.termguicolors = true

-- Colorscheme
-- cmd [[colorscheme material]]
-- cmd [[colorscheme one-nvim]]
-- cmd [[colorscheme tokyonight]]
-- cmd [[colorscheme gruvbox]]

require('onedark').setup {
    style = 'dark'
}
require('onedark').load()
