local nnoremap = require("sam.keymap").nnoremap

nnoremap("<leader>t", "<cmd>Telescope<cr>")

-- search
nnoremap("<C-p>", require("sam.telescope").search_files)
nnoremap("<leader><leader>", require("telescope.builtin").git_files)
nnoremap("<leader>z", require("sam.telescope").search_configs)
nnoremap("<leader>j", require("sam.telescope").search_work_dirs)

nnoremap("<leader>a", require("telescope.builtin").live_grep)
nnoremap("<leader>e", require("sam.telescope").edit_neovim)

-- utils
nnoremap("<leader>c", require("telescope.builtin").colorscheme)
nnoremap("<leader><enter>", require("telescope.builtin").buffers)
nnoremap("<leader>m", require("telescope.builtin").keymaps)
nnoremap("<leader><space>", require("telescope").extensions.projects.projects)
