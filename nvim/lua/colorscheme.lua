local opt = vim.opt
-- local cmd = vim.cmd

opt.background = 'dark'
opt.termguicolors = true

-- Colorscheme
-- cmd [[colorscheme material]]
-- cmd [[colorscheme one-nvim]]
-- cmd [[colorscheme tokyonight]]

vim.g.onedark_style = 'dark'
require('onedark').setup()
