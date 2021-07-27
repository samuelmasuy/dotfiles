local api = vim.api

api.nvim_set_keymap("", "\\", ",", {noremap = true})
-- Open in a new tab .vimrc
api.nvim_set_keymap("n", "<leader>e", ":tabedit $MYVIMRC<CR>", {noremap = true})
-- Remap visual block select.
api.nvim_set_keymap("n", "<leader>v", "<c-v>", {noremap = true})
-- Open new vertical split
api.nvim_set_keymap("n", "<leader>vs", ":vsplit<CR>", {noremap = true})
-- Map sort function to a key
api.nvim_set_keymap("v", "<leader>s", ":sort<CR>", {noremap = true})
-- Remove trailing whitespace on <leader>S
api.nvim_set_keymap("n", "<leader>S", ":%s/\\s\\+$//<cr>:let @/=''<CR>", {noremap = true})
-- Reset space-tab
api.nvim_set_keymap("n", "<leader>reta", ":retab<CR>", {noremap = true})

-- cd to where the file is currently located
api.nvim_set_keymap("n", "<leader>.", ":lcd %:p:h<CR>", {noremap = true})

-- Google search word under cursor from http://www.vimbits.com/bits/551
api.nvim_set_keymap("n", "<leader>is", ":let @p=@\"<cr>yiw:!open \"https://www.google.com/search?q=\"\"<cr><cr>:let @\"=@p<cr>", {noremap = true})

api.nvim_set_keymap("v", "<leader>is", "y:!open \"https://www.google.com/search?q=\"\"<cr><cr>", {noremap = true})

-- Google search the definition of the word under cursor
api.nvim_set_keymap("n", "<leader>id", ":let @p=@\"<cr>yiw:!open \"https://www.google.com/search?q=define \"\"<cr><cr>:let @\"=@p<cr>", {noremap = true})

-- urlencode selection
api.nvim_set_keymap("v", "<leader>en", ":!python -c 'import sys,urllib;print urllib.quote(sys.stdin.read().strip())'<cr>", {noremap = true})

-- Easy substitution
api.nvim_set_keymap("n", "<leader>;", ":%s::cg<Left><Left><Left>", {noremap = true})
api.nvim_set_keymap("v", "<leader>;", ":s::g<Left><Left>", {noremap = true})

-- Don't lose what's in "" register
api.nvim_set_keymap("v", "<leader>p", '"_dp', {noremap = true})

-- redraw screen
api.nvim_set_keymap("n", "<leader>1", ":redraw!<CR>", {noremap = true})

-- use <Leader>H,J,K,L to swap windows
api.nvim_set_keymap("", "<leader>H", ":vertical :resize +5<CR>", {noremap = true, silent = true})
api.nvim_set_keymap("", "<leader>J", ":resize -5<CR>", {noremap = true, silent = true})
api.nvim_set_keymap("", "<leader>K", ":resize +5<CR>", {noremap = true, silent = true})
api.nvim_set_keymap("", "<leader>L", ":vertical :resize -5<CR>", {noremap = true, silent = true})

api.nvim_set_keymap("n", "<leader>tn", ":TestNearest<CR>", {noremap = true})
api.nvim_set_keymap("n", "<leader>tf", ":TestFile<CR>", {noremap = true})
