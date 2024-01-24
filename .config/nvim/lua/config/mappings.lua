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
nnoremap("<left>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
nnoremap("<right>", "<cmd>bnext<CR>", { desc = "next buffer" })

-- Up and down can switch quickfix list
nnoremap("<leader>qp", "<cmd>cprevious<CR>", { desc = "Previous quickfix" })
nnoremap("<leader>qn", "<cmd>cnext<CR>", { desc = "Next quickfix" })

nnoremap("<space>q", function()
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

-- Telescope
nnoremap("<leader>t", "<cmd>Telescope<cr>", { desc = "[t]elescope" })

-- search
nnoremap("<C-p>", require("sam.telescope").search_files, { desc = "Search Files" })
nnoremap("<leader><leader>", require("telescope.builtin").git_files, { desc = "Search Git files" })
nnoremap("<leader>x", require("sam.telescope").search_configs, { desc = "Config[x]" })
nnoremap("<leader>z", require("sam.telescope").search_dotfiles, { desc = "Dotfile[z]" })
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

-- Git
nnoremap("<leader>g", "<cmd>G<cr>]]", { desc = "[g]it" })
nnoremap("<leader>gp", "<cmd>GPush<cr>", { desc = "[g]it [p]ush" })
nnoremap("<leader>gl", "<cmd>GPull<cr>", { desc = "[g]it pu[l]l" })

-- Diff
nnoremap("<leader>dor", "<cmd>diffget REMOTE<CR>", { desc = "[d]iff [o]btain [r]emote" })
nnoremap("<leader>dol", "<cmd>diffget LOCAL<CR>", { desc = "[d]iff [o]btain [l]ocal" })
nnoremap("<leader>dob", "<cmd>diffget BASE<CR>", { desc = "[d]iff [o]btain [b]ase" })

-- Git worktree
nnoremap(
  "<leader>sw",
  require("telescope").extensions.git_worktree.git_worktrees,
  { desc = "[S]earch Git [W]orktrees", noremap = true, silent = true }
)
nnoremap(
  "<leader>wt",
  require("telescope").extensions.git_worktree.create_git_worktree,
  { desc = "Create Git [W]ork[t]ree", noremap = true, silent = true }
)

-- Mini
nnoremap("-", function()
  require("mini.files").open(vim.api.nvim_buf_get_name(0))
end, { desc = "Open mini.files" })

-- Dial
nnoremap("<C-a>", function()
  require("dial.map").manipulate("increment", "normal")
end, { desc = "Dial Up" })
nnoremap("<C-x>", function()
  require("dial.map").manipulate("decrement", "normal")
end, { desc = "Dial down" })
vnoremap("<C-a>", function()
  require("dial.map").manipulate("increment", "visual")
end, { desc = "Dial Up" })
vnoremap("<C-x>", function()
  require("dial.map").manipulate("decrement", "visual")
end, { desc = "Dial down" })
