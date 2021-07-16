-- General Mappings
-- try to use ZZ
vim.api.nvim_set_keymap("c", "wq", ":echo 'Use ZZ or :x'<CR>", {noremap = true})

-- Disable un-VI keys.
vim.api.nvim_set_keymap("n", "<up>", "<nop>", {noremap = true})
vim.api.nvim_set_keymap("n", "<down>", "<nop>", {noremap = true})
vim.api.nvim_set_keymap("i", "<up>", "<nop>", {noremap = true})
vim.api.nvim_set_keymap("i", "<down>", "<nop>", {noremap = true})
vim.api.nvim_set_keymap("i", "<left>", "<nop>", {noremap = true})
vim.api.nvim_set_keymap("i", "<right>", "<nop>", {noremap = true})

-- Left and right can switch buffers
vim.api.nvim_set_keymap("n", "<left>", ":bprevious<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<right>", ":bnext<CR>", {noremap = true})

-- Up and down can switch quickfix list
vim.api.nvim_set_keymap("n", "<up>", ":cprevious<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<down>", ":cnext<CR>", {noremap = true})

-- Quick Fold and Unfold.
-- vim.api.nvim_set_keymap("n", "<space>", "za", {noremap = true})
-- vim.api.nvim_set_keymap("v", "<space>", "zf", {noremap = true})

-- Make sure to be in the middle of the screen when searching.
vim.api.nvim_set_keymap("n", "n", "nzzzv", {noremap = true})
vim.api.nvim_set_keymap("n", "N", "Nzzzv", {noremap = true})

-- Easier indentation of code blocks.
vim.api.nvim_set_keymap("v", "<", "<gv", {noremap = true})
vim.api.nvim_set_keymap("v", ">", ">gv", {noremap = true})

-- basic, why not before
vim.api.nvim_set_keymap("n", ";", ":", {noremap = true})
vim.api.nvim_set_keymap("n", ":", ";", {noremap = true})
vim.api.nvim_set_keymap("v", ";", ":", {noremap = true})
vim.api.nvim_set_keymap("v", ":", ";", {noremap = true})

-- logical
vim.api.nvim_set_keymap("n", "Y", "y$", {noremap = true})

-- Switch marks
vim.api.nvim_set_keymap("n", "'", "`", {noremap = true})
vim.api.nvim_set_keymap("n", "`", "'", {noremap = true})

-- Don't move on *
vim.api.nvim_set_keymap("n", "*", ":let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>", {noremap = true, silent = true})

-- Terminal mode
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", {noremap = true})
vim.api.nvim_set_keymap("t", "<C-h>", "<C-\\><C-n><C-w>h", {noremap = true})
vim.api.nvim_set_keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", {noremap = true})
vim.api.nvim_set_keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", {noremap = true})
vim.api.nvim_set_keymap("t", "<C-l>", "<C-\\><C-n><C-w>l", {noremap = true})
