local nnoremap = require("sam.keymap").nnoremap

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
