-- General Mappings
-- try to use ZZ
vim.keymap.set("c", "wq", ":echo 'Use ZZ or :x'<CR>")

-- Disable un-VI keys.
-- vim.keymap.set("n", "<up>", "<nop>")
-- vim.keymap.set("n", "<down>", "<nop>")
vim.keymap.set("i", "<up>", "<nop>")
vim.keymap.set("i", "<down>", "<nop>")
vim.keymap.set("i", "<left>", "<nop>")
vim.keymap.set("i", "<right>", "<nop>")

-- Left and right can switch buffers
vim.keymap.set("n", "<left>", ":bprevious<CR>")
vim.keymap.set("n", "<right>", ":bnext<CR>")

-- Up and down can switch quickfix list
vim.keymap.set("n", "<up>", ":cprevious<CR>")
vim.keymap.set("n", "<down>", ":cnext<CR>")

-- Quick Fold and Unfold.
-- vim.keymap.set("n", "<space>", "za")
-- vim.keymap.set("v", "<space>", "zf")

-- Make sure to be in the middle of the screen when searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- Make sure to stay at current cursor position when joining
vim.keymap.set("n", "J", "mzJ`v")

-- Easier indentation of code blocks.
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- basic, why not before
vim.keymap.set("n", ";", ":")
vim.keymap.set("n", ":", ";")
vim.keymap.set("v", ";", ":")
vim.keymap.set("v", ":", ";")

-- logical, why vi
vim.keymap.set("n", "Y", "y$")

-- Switch marks
-- vim.keymap.set("n", "'", "`")
-- vim.keymap.set("n", "`", "'")

-- Don't move on *
vim.keymap.set("n", "*", ":let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>", {noremap = true, silent = true})

-- Terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l")
