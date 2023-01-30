local Remap = require("sam.keymap")
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
nnoremap("<left>", "<cmd>bprevious<CR>")
nnoremap("<right>", "<cmd>bnext<CR>")

-- Up and down can switch quickfix list
nnoremap("<up>", "<cmd>cprevious<CR>")
nnoremap("<down>", "<cmd>cnext<CR>")

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
nnoremap("-", vim.cmd.Ex)

-- Telescope
nnoremap("<leader>t", "<cmd>Telescope<cr>", { desc = "[t]elescope" })

-- search
nnoremap("<C-p>", require("sam.telescope").search_files, { desc = "Search Files" })
nnoremap("<leader><leader>", require("telescope.builtin").git_files, { desc = "Search Git files" })
nnoremap("<leader>z", require("sam.telescope").search_configs, { desc = "Config[z]" })
nnoremap("<leader>j", require("sam.telescope").search_work_dirs, { desc = "Work dirs" })
nnoremap("<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })

-- nnoremap("<leader>a", require("telescope.builtin").live_grep, { desc = "Rg" })
nnoremap("<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
nnoremap("<leader>e", require("sam.telescope").edit_neovim, { desc = "[e]dit Neovim configs" })

-- utils
nnoremap("<leader>c", require("telescope.builtin").colorscheme, { desc = "[c]olorscheme" })
nnoremap("<leader><enter>", require("telescope.builtin").buffers, { desc = "[<CR>] Find existing buffers" })
nnoremap("<leader>m", require("telescope.builtin").keymaps, { desc = "Key[m]aps" })
nnoremap("<leader><space>", require("telescope").extensions.projects.projects, { desc = "[ ] Search projects" })
nnoremap("<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
nnoremap("<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
nnoremap("<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })

-- LSP
-- Diagnostic keymaps
nnoremap("[d", vim.diagnostic.goto_prev)
nnoremap("]d", vim.diagnostic.goto_next)
nnoremap("gl", vim.diagnostic.open_float)
nnoremap("<leader>q", vim.diagnostic.setloclist)

nnoremap("<space>d", require("sam.lsp").LspSwap)
