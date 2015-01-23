" vim:fdm=marker
" Author: Samuel Masuy and the vim community.

" Tip Macros: important!!!
" "ap: put (print) content of macro in register a.
" "ayy: put back current line in register a (macro).

" Pre vim  --------------------------------------------------------------- {{{

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Better copy & paste.
set clipboard=unnamed
" See the commands typed in the right bottom corner.
set showcmd
" Make backspace behave like normal.
set bs=2

call plug#begin('~/.vim/plugged')

" Essential
Plug 'morhetz/gruvbox'
Plug 'davidhalter/jedi-vim'
Plug 'ervandew/supertab'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
" Adds Unix commands to vim.
Plug 'tpope/vim-eunuch'
" To change surrounding quote: cs"' ;tag cst<th> ;to add quote ysW'
Plug 'tpope/vim-surround'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree'
Plug 'SirVer/ultisnips'
Plug 'mattn/emmet-vim'
" :DirDiff <A:Src Directory> <B:Src Directory>
Plug 'vim-scripts/DirDiff.vim'
" Activate with <leader><leader>w (by word) <leader><leader>fo (character o)
Plug 'Lokaltog/vim-easymotion'
" <leader>ig
Plug 'nathanaelkane/vim-indent-guides'
Plug 'Valloric/MatchTagAlways'
" Provide automatic closing quotes, etc...
Plug 'Raimondi/delimitMate'

" Not very necessary
" visual mode :Tabularize/{Regex}
Plug 'godlygeek/tabular'
Plug 'terryma/vim-multiple-cursors'
Plug 'sjl/gundo.vim'
Plug 'dahu/vim-fanfingtastic'

" Syntax helpers
Plug 'StanAngeloff/php.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'pangloss/vim-javascript'
Plug 'burnettk/vim-angular'
Plug 'plasticboy/vim-markdown'

" Tmux
Plug 'tmux-plugins/vim-tmux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'

" Dependencies
Plug 'honza/vim-snippets'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'

" Plug 'tommcdo/vim-exchange'
" Plug 'alfredodeza/pytest.vim'
" Plug 'vim-scripts/SQLComplete.vim'
" Plug 'marijnh/tern_for_vim'
" Plug 'altercation/vim-colors-solarized'
" Plug 'junegunn/seoul256.vim'

call plug#end()

set nocompatible
filetype plugin indent on

" ------------------------------------------------------------------------ }}}
" Appearance  ------------------------------------------------------------ {{{

" Beautiful
set t_Co=256
" Auto Indent
set autoindent
" Enable syntax highlighting.
syntax on

" Show whitespace.
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Font for macvim.
if has("gui_running")
    set guifont=Monaco:h15
endif

" Color scheme.
set background=dark
colorscheme gruvbox
" colorscheme solarized
" colorscheme seoul256

" ------------------------------------------------------------------------ }}}
" Miscellaneous settings ------------------------------------------------- {{{

" Show the line that have been wrapped.
let &showbreak='↪ '
" Gdiff vertical split
set diffopt+=vertical
" Make Esc work faster.
set ttimeoutlen=50
" Always shows 5 lines above/below the cursor.
set scrolloff=5
" Increment decimal not octal numbers.
set nrformats=
" Horizontal split goes to the bottom.
set splitbelow
" Vertical split goes to the right.
set splitright

" Colorize the 80th column.
"set colorcolumn=81
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" Folding settings.

" Don't use TABs but spaces.
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Showing line numbers and length.
set relativenumber
" Show current line numbers.
set number
" Width of document.
set tw=79
" Don't automatically wrap on load.
set nowrap
" Don't automatically wrap text when typing.
set fo-=t

" Useful settings.
set history=700
set undolevels=700

" Make search case insensitive.
set hlsearch
set incsearch
set ignorecase
set smartcase

" Disable backup and swap files.
set nobackup
set nowritebackup
set noswapfile

" ------------------------------------------------------------------------ }}}
" General Mapping  ------------------------------------------------------- {{{

" Disable un-VI keys.
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Quick Fold and Unfold.
nnoremap <space> za
vnoremap <space> zf

" Go start and end of line.
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $

" Make sure to be in the middle of the screen when searching.
nnoremap n nzzzv
nnoremap N Nzzzv

" Easier indentation of code blocks.
vnoremap < <gv
vnoremap > >gv

"basic, why not before
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" ------------------------------------------------------------------------ }}}
" Leader Key Mapping  ---------------------------------------------------- {{{

" Rebind <Leader> key.
let g:mapleader = ','

" Remap changing screen keys.
map <leader>h <C-w>h
map <leader>j <C-w>j
map <leader>k <C-w>k
map <leader>l <C-w>l
" Open in a new tab .vimrc
nnoremap <leader>e :tabedit $MYVIMRC<CR>
" Pytest the current file.
"nnoremap <silent><Leader>f <Esc>:Pytest file<CR>
" Remap visual block select.
nnoremap <Leader>v <c-v>
" Quicksave command.
noremap <Leader>s :w<CR>
" Map sort function to a key
vnoremap <Leader>s :sort<CR>
" Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>
" Ack on <leader>a
nnoremap <leader>a :Ack<space>

" Title helper with reStructuredText files.
if (&ft=='rst')
    function! Underline(symbol, overline)
        let lineNo = line('.')
        let counter = strlen(getline('.'))
        let newLine = ''
        while counter > 0
            let newLine  = newLine . a:symbol
            let counter -= 1
        endwhile
        call append(lineNo, newLine)
        if a:overline > 0
            call append(lineNo-1, newLine)
            let lineNo = lineNo + 1
        endif
        call append(lineNo + 1, "")
        call cursor(lineNo+2,1)
    endfunction

    nnoremap <Leader>1 :call Underline('#',1)<cr>
    nnoremap <Leader>2 :call Underline('*',1)<cr>
    nnoremap <Leader>3 :call Underline('=',0)<cr>
    nnoremap <Leader>4 :call Underline('-',0)<cr>
    nnoremap <Leader>5 :call Underline('~',0)<cr>
endif

" ------------------------------------------------------------------------ }}}
" Plugins setup. --------------------------------------------------------- {{{
" Settings for vim-powerline
let s:uname = system("uname")
if s:uname == "Darwin\n"
    source /usr/local/lib/python2.7/site-packages/powerline/bindings/vim/plugin/powerline.vim
    set laststatus=2
    " Hide the default mode text
    set noshowmode
    let g:Powerline_symbols = "fancy"
    set encoding=utf-8
    set fillchars+=stl:\ ,stlnc:\
    if has("gui_running")
          set guifont=Monaco\ for\ Powerline
    endif
endif

" Settings for syntastic
let g:syntastic_python_checkers = ['pylint', 'flake8']
let g:syntastic_aggregate_errors = 1

" Settings for vim-multiple-cursors
let g:multi_cursor_exit_from_insert_mode = 0
let g:multi_cursor_exit_from_visual_mode = 0

" Settings for jedi-vim
let g:jedi#popup_select_first = 0

" Settings for UtilSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsListSnippets="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Settings for emmet-vim
let g:user_emmet_expandabbr_key='<Tab>'

" Settings for super-tab
let g:SuperTabDefaultCompletionType = "context"

" Settings for nerdTree
nnoremap <Leader>x :NERDTreeToggle<CR>
let NERDTreeIgnore=['.pyc$[[file]]']
let NERDTreeShowHidden=1
let NERDTreeMapActivateNode='<space>'

" Settings for nerdCommenter
let NERDSpaceDelims=1

" Settings for javascript-libraries-syntax.vim
let g:used_javascript_libs = 'angularui'

" Settings for Ack.vim
let g:ackhighlight = 1
let g:ack_autofold_results = 1
let g:ackpreview = 1
let g:ackprg = 'ag --nogroup --nocolor --column'

" Vimux settings
 " Prompt for a command to run
 nnoremap <Leader>cc :VimuxPromptCommand<CR>
 " Run last command executed by VimuxRunCommand
 nnoremap <Leader>cu :VimuxRunLastCommand<CR>

" ------------------------------------------------------------------------ }}}

