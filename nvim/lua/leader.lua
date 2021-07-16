vim.api.nvim_set_keymap("", "\\", ",", {noremap = true})
-- Open in a new tab .vimrc
vim.api.nvim_set_keymap("n", "<leader>e", ":tabedit $MYVIMRC<CR>", {noremap = true})
-- Remap visual block select.
vim.api.nvim_set_keymap("n", "<leader>v", "<c-v>", {noremap = true})
-- Open new vertical split
vim.api.nvim_set_keymap("n", "<leader>vs", ":vsplit<CR>", {noremap = true})
-- Map sort function to a key
vim.api.nvim_set_keymap("v", "<leader>s", ":sort<CR>", {noremap = true})
-- Remove trailing whitespace on <leader>S
vim.api.nvim_set_keymap("n", "<leader>S", ":%s/\\s\\+$//<cr>:let @/=''<CR>", {noremap = true})
-- Reset space-tab
vim.api.nvim_set_keymap("n", "<leader>reta", ":retab<CR>", {noremap = true})

-- cd to where the file is currently located
vim.api.nvim_set_keymap("n", "<leader>.", ":lcd %:p:h<CR>", {noremap = true})

-- Google search word under cursor from http://www.vimbits.com/bits/551
vim.api.nvim_set_keymap("n", "<leader>is", ":let @p=@\"<cr>yiw:!open \"https://www.google.com/search?q=\"\"<cr><cr>:let @\"=@p<cr>", {noremap = true})

vim.api.nvim_set_keymap("v", "<leader>is", "y:!open \"https://www.google.com/search?q=\"\"<cr><cr>", {noremap = true})

-- Google search the definition of the word under cursor
vim.api.nvim_set_keymap("n", "<leader>id", ":let @p=@\"<cr>yiw:!open \"https://www.google.com/search?q=define \"\"<cr><cr>:let @\"=@p<cr>", {noremap = true})

-- urlencode selection
vim.api.nvim_set_keymap("v", "<leader>en", ":!python -c 'import sys,urllib;print urllib.quote(sys.stdin.read().strip())'<cr>", {noremap = true})

-- Easy substitution
vim.api.nvim_set_keymap("n", "<leader>;", ":%s::cg<Left><Left><Left>", {noremap = true})
vim.api.nvim_set_keymap("v", "<leader>;", ":s::g<Left><Left>", {noremap = true})

-- redraw screen
vim.api.nvim_set_keymap("n", "<leader>1", ":redraw!<CR>", {noremap = true})

-- use <Leader>H,J,K,L to swap windows
vim.api.nvim_set_keymap("", "<leader>H", ":vertical :resize +5<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("", "<leader>J", ":resize -5<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("", "<leader>K", ":resize +5<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("", "<leader>L", ":vertical :resize -5<CR>", {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "<leader>tn", ":TestNearest<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>tf", ":TestFile<CR>", {noremap = true})
