local keymap = vim.keymap

keymap.set("", "\\", ",", {noremap = true})
-- Open in a new tab .vimrc
keymap.set("n", "<leader>e", ":tabedit $MYVIMRC<CR>", {noremap = true})
-- Remap visual block select.
-- keymap.set("n", "<leader>v", "<c-v>", {noremap = true})
-- Open new vertical split
keymap.set("n", "<leader>v", ":vsplit<CR>", {noremap = true})
-- Map sort function to a key
-- keymap.set("v", "<leader>s", ":sort<CR>", {noremap = true})
-- Remove trailing whitespace on <leader>S
keymap.set("n", "<leader>S", ":%s/\\s\\+$//<cr>:let @/=''<CR>", {noremap = true})
-- Reset space-tab
-- keymap.set("n", "<leader>reta", ":retab<CR>", {noremap = true})

-- cd to where the file is currently located
keymap.set("n", "<leader>.", ":lcd %:p:h<CR>", {noremap = true})

-- Google search word under cursor from http://www.vimbits.com/bits/551
keymap.set("n", "<leader>is", ":let @p=@\"<cr>yiw:!open \"https://www.google.com/search?q=\"\"<cr><cr>:let @\"=@p<cr>", {noremap = true})
keymap.set("v", "<leader>is", "y:!open \"https://www.google.com/search?q=\"\"<cr><cr>", {noremap = true})
-- Google search the definition of the word under cursor
keymap.set("n", "<leader>id", ":let @p=@\"<cr>yiw:!open \"https://www.google.com/search?q=define \"\"<cr><cr>:let @\"=@p<cr>", {noremap = true})

-- urlencode selection
keymap.set("v", "<leader>en", ":!python -c 'import sys,urllib;print urllib.quote(sys.stdin.read().strip())'<cr>", {noremap = true})

-- Easy substitution
keymap.set("n", "<leader>;", ":%s::cg<Left><Left><Left>", {noremap = true})
keymap.set("v", "<leader>;", ":s::g<Left><Left>", {noremap = true})

-- Don't lose what's in "" register
keymap.set("v", "<leader>p", '"_dp', {noremap = true})

-- redraw screen
-- keymap.set("n", "<leader>1", ":redraw!<CR>", {noremap = true})

-- use <Leader>H,J,K,L to swap windows
keymap.set("", "<leader>H", ":vertical :resize +5<CR>", {noremap = true, silent = true})
keymap.set("", "<leader>J", ":resize -5<CR>", {noremap = true, silent = true})
keymap.set("", "<leader>K", ":resize +5<CR>", {noremap = true, silent = true})
keymap.set("", "<leader>L", ":vertical :resize -5<CR>", {noremap = true, silent = true})

keymap.set("n", "<leader>tn", ":TestNearest<CR>", {noremap = true})
keymap.set("n", "<leader>tf", ":TestFile<CR>", {noremap = true})
