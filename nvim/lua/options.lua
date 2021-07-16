vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.autowrite = true
vim.opt.inccommand = 'nosplit'

vim.opt.laststatus = 2
vim.opt.showcmd = true
-- Show the line that have been wrapped.
vim.opt.showbreak = '↪ '
-- Completion options (select longest + show menu even if a single match is found)
-- vim.opt.completeopt = 'menuone,noselect'
vim.cmd 'autocmd CompleteDone * pclose'
-- Make Esc work faster.
vim.opt.ttimeoutlen = 40
-- Always shows 5 lines above/below the cursor.
vim.opt.scrolloff = 5
-- " Increment decimal not octal numbers.
vim.opt.nrformats=''
-- Horizontal split goes to the bottom.
vim.opt.splitbelow = true
-- Vertical split goes to the right.
vim.opt.splitright = true
-- Automatically reread changed files without asking me anything
vim.opt.autoread = true
-- speed up syntax highlighting
vim.opt.cursorcolumn = false
vim.opt.cursorline = false

--Showing line numbers and length.
-- vim.opt.relativenumber = true
-- Show current line numbers.
vim.opt.number = true
-- Width of document.
vim.opt.tw = 79
-- Don't automatically wrap on load.
vim.opt.wrap = false
vim.opt.formatoptions:remove({
    't',                       -- Don't auto wrap text
    'o',                       -- Do not continue comments with 'o' or 'O'
    '2',                       -- ... that's just weird
})

-- How many undos
vim.opt.undolevels = 1000
-- Undo file
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Wildmode aka tab-completion options.
vim.opt.wildmode = 'full'

-- for argdo and bufdo without a trailing bang.
vim.opt.hidden = true

-- Disable backup and swap files.
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

vim.opt.mouse:remove({
    'a', -- Disable mouse click to go to position
})

vim.opt.showmode = false

-- if vim.fn.executable "rg" then
--   vim.opt.grepprg = 'rg\ --vimgrep'
--   vim.opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
-- end

vim.opt.diffopt:append {
    'vertical',           -- Gdiff vertical split
    'algorithm:patience', -- Make diffing better: https://vimways.org/2018/the-power-of-diff/
    'indent-heuristic',
}

-- gnupg
vim.opt.modeline = true
vim.opt.modelines = 5

-- Better display for messages
-- vim.opt.cmdheight = 1
-- Smaller updatetime for CursorHold & CursorHoldI
vim.opt.updatetime = 300

 -- don't give |ins-completion-menu| messages.
vim.opt.shortmess     = vim.opt.shortmess + 'c'

-- " always show signcolumns
vim.opt.signcolumn = 'yes'

-- Colorize the 100th column if goes over.
vim.cmd('highlight ColorColumn ctermbg=magenta')
vim.fn.matchadd('ColorColumn', '\\%101v', 100)
