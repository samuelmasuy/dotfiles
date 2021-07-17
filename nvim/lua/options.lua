local opt = vim.opt
local cmd = vim.cmd

cmd 'syntax enable'
cmd 'filetype plugin indent on'
opt.clipboard = "unnamed"

opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = 4

opt.autowrite = true
opt.inccommand = 'nosplit'

opt.laststatus = 2
opt.showcmd = true
-- Show the line that have been wrapped.
opt.showbreak = '↪ '
-- Completion options (select longest + show menu even if a single match is found)
-- opt.completeopt = 'menuone,noselect'
cmd 'autocmd CompleteDone * pclose'
-- Make Esc work faster.
opt.ttimeoutlen = 40
-- Always shows 5 lines above/below the cursor.
opt.scrolloff = 5
-- " Increment decimal not octal numbers.
opt.nrformats=''
-- Horizontal split goes to the bottom.
opt.splitbelow = true
-- Vertical split goes to the right.
opt.splitright = true
-- Automatically reread changed files without asking me anything
opt.autoread = true
-- speed up syntax highlighting
opt.cursorcolumn = false
opt.cursorline = false

--Showing line numbers and length.
-- opt.relativenumber = true
-- Show current line numbers.
opt.number = true
-- Width of document.
opt.tw = 79
-- Don't automatically wrap on load.
opt.wrap = false
opt.formatoptions:remove({
    't',                       -- Don't auto wrap text
    'o',                       -- Do not continue comments with 'o' or 'O'
    '2',                       -- ... that's just weird
})

-- How many undos
opt.undolevels = 1000
-- Undo file
opt.undofile = true

opt.ignorecase = true
opt.smartcase = true

-- Wildmode aka tab-completion options.
opt.wildmode = 'full'

-- for argdo and bufdo without a trailing bang.
opt.hidden = true

-- Disable backup and swap files.
opt.backup = false
opt.writebackup = false
opt.swapfile = false

opt.mouse:remove({
    'a', -- Disable mouse click to go to position
})

opt.showmode = false

opt.diffopt:append {
    'vertical',           -- Gdiff vertical split
    'algorithm:patience', -- Make diffing better: https://vimways.org/2018/the-power-of-diff/
    'indent-heuristic',
}

-- gnupg
opt.modeline = true
opt.modelines = 5

-- Better display for messages
-- opt.cmdheight = 1
-- Smaller updatetime for CursorHold & CursorHoldI
opt.updatetime = 300

 -- don't give |ins-completion-menu| messages.
opt.shortmess = opt.shortmess + 'c'

-- " always show signcolumns
opt.signcolumn = 'yes'

-- Colorize the 100th column if goes over.
cmd 'highlight ColorColumn ctermbg=magenta'
vim.fn.matchadd('ColorColumn', '\\%101v', 100)
