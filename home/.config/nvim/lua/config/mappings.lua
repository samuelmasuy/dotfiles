local Remap = require("sam.utilities")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local tnoremap = Remap.tnoremap
local cnoremap = Remap.cnoremap
local xnoremap = Remap.xnoremap
-- General Mappings
-- try to use ZZ
cnoremap("wq", ":echo 'Use ZZ or :x'<CR>")
-- vim.keymap.set("c", "wq", ":echo 'Use ZZ or :x'<CR>")
-- vim.keymap.set(op, lhs, rhs, opts)

-- Disable un-VI keys.
-- vim.keymap.set("n", "<up>", "<nop>")
-- vim.keymap.set("n", "<down>", "<nop>")
inoremap("<up>", "<nop>")
inoremap("<down>", "<nop>")
inoremap("<left>", "<nop>")
inoremap("<right>", "<nop>")

-- Left and right can switch buffers
nnoremap("[b", "<cmd>bprevious<CR>", { desc = "Previous [b]uffer" })
nnoremap("]b", "<cmd>bnext<CR>", { desc = "Next [b]uffer" })

-- Up and down can switch quickfix list
nnoremap("[q", "<cmd>cprevious<CR>", { desc = "Previous [q]uickfix" })
nnoremap("]q", "<cmd>cnext<CR>", { desc = "Next [q]uickfix" })

nnoremap("<leader>q", function()
  local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
  local action = qf_winid > 0 and "cclose" or "copen"
  vim.cmd("botright " .. action)
end, { desc = "Toggle quickfix", noremap = true, silent = true })

-- Quick Fold and Unfold.
-- nnoremap("<space>", "za")
-- vnoremap("<space>", "zf")

-- Make sure to be in the middle of the screen when navigating half page
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
-- Make sure to be in the middle of the screen when searching
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
-- Make sure to stay at current cursor position when joining
nnoremap("J", "mzJ`z")

-- Easier indentation of code blocks.
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- basic, why not before
nnoremap(";", ":")
nnoremap(":", ";")
vnoremap(";", ":")
vnoremap(":", ";")

-- logical, why vi
nnoremap("Y", "y$")

-- Switch marks
-- vim.keymap.set("n", "'", "`")
-- vim.keymap.set("n", "`", "'")

-- Move with visuals
xnoremap("K", ":m-2<CR>gv=gv")
xnoremap("J", ":m'>+<CR>gv=gv")

-- Don't move on *
nnoremap(
  "*",
  "<cmd>let stay_star_view = winsaveview()<cr>*<cmd>call winrestview(stay_star_view)<cr>",
  { noremap = true, silent = true }
)

-- Terminal mode
tnoremap("<Esc>", "<C-\\><C-n>")
tnoremap("<C-h>", "<C-\\><C-n><C-w>h")
tnoremap("<C-j>", "<C-\\><C-n><C-w>j")
tnoremap("<C-k>", "<C-\\><C-n><C-w>k")
tnoremap("<C-l>", "<C-\\><C-n><C-w>l")

-- Ex
-- nnoremap("-", vim.cmd.Ex, { desc = "Open netrw" })

-- Diff
nnoremap("<leader>dor", "<cmd>diffget REMOTE<CR>", { desc = "[d]iff [o]btain [r]emote" })
nnoremap("<leader>dol", "<cmd>diffget LOCAL<CR>", { desc = "[d]iff [o]btain [l]ocal" })
nnoremap("<leader>dob", "<cmd>diffget BASE<CR>", { desc = "[d]iff [o]btain [b]ase" })
