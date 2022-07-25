local nnoremap = require("sam.keymap").nnoremap

nnoremap("<leader>t", "<cmd>Telescope<cr>")

-- search
nnoremap("<C-p>", function()
	require("sam.telescope").search_files()
end)
nnoremap("<leader><leader>", function()
	require("telescope.builtin").git_files()
end)
nnoremap("<leader>z", function()
	require("sam.telescope").search_configs()
end)
nnoremap("<leader>j", function()
	require("sam.telescope").search_work_dirs()
end)

nnoremap("<leader>f", function()
	require("telescope").extensions.frecency.frecency()
end)

nnoremap("<leader>a", function()
	require("telescope.builtin").live_grep()
end)

nnoremap("<leader>e", function()
	require("sam.telescope").edit_neovim()
end)

-- utils
nnoremap("<leader>c", function()
	require("telescope.builtin").colorscheme()
end)
nnoremap("<leader><enter>", function()
	require("telescope.builtin").buffers()
end)
nnoremap("<leader>m", function()
	require("telescope.builtin").keymaps()
end)
nnoremap("<space>ca", function()
	require("sam.telescope").lsp_code_actions()
end)
