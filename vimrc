" vim:fdm=marker
" Author: Samuel Masuy and the vim community.

" To make a portable tar vim:
" bash <(curl -L https://raw.githubusercontent.com/junegunn/myvim/master/myvim)

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
Plug 'tpope/vim-eunuch' " Adds Unix commands to vim.
Plug 'tpope/vim-surround' " To change surrounding quote: cs(' ;tag cst<th> ;to add quote ysW'
Plug 'kien/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'tmux-plugins/vim-tmux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
Plug 'mileszs/ack.vim'

Plug 'Valloric/MatchTagAlways'
Plug 'Raimondi/delimitMate' " Provide automatic closing quotes, etc...
" Plug 'dahu/vim-fanfingtastic'
Plug 'vim-scripts/DirDiff.vim' " :DirDiff <A:Src Directory> <B:Src Directory>

" Not very necessary
Plug 'scrooloose/nerdtree'
Plug 'sjl/gundo.vim'
Plug 'dahu/vimple'
" Plug 'godlygeek/tabular' " visual mode :Tabularize/{Regex}
" Plug 'Lokaltog/vim-easymotion' " Activate with <leader><leader>w (by word) <leader><leader>fo (character o)
" Plug 'nathanaelkane/vim-indent-guides' " <leader>ig
" Plug 'terryma/vim-multiple-cursors'

" Syntax helpers
" Plug 'SirVer/ultisnips'
" Plug 'mattn/emmet-vim'
" Plug 'StanAngeloff/php.vim'
" Plug 'othree/javascript-libraries-syntax.vim'
" Plug 'pangloss/vim-javascript'
" Plug 'burnettk/vim-angular'
" Plug 'plasticboy/vim-markdown'

" Dependencies
" Plug 'honza/vim-snippets'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'

" Plug 'tommcdo/vim-exchange'
" Plug 'alfredodeza/pytest.vim'
" Plug 'vim-scripts/SQLComplete.vim'
" Plug 'marijnh/tern_for_vim'
" Plug 'altercation/vim-colors-solarized'
" Plug 'chriskempson/vim-tomorrow-theme'
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

" Wildmode aka tab-completion options.
set wildmenu
set wildmode=full

" for argdo and bufdo without a trailing bang.
set hidden

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
" Avoid un-VI keys in ex mode
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Quick Fold and Unfold.
nnoremap <space> za
vnoremap <space> zf

" Go start and end of line.
" nnoremap H ^
" nnoremap L $
" vnoremap H ^
" vnoremap L $

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
" nmap : <Plug>fanfingtastic_;
" xmap : <Plug>fanfingtastic_;
" omap : <Plug>fanfingtastic_;
" vmap : <Plug>fanfingtastic_;

" ------------------------------------------------------------------------ }}}
" Leader Key Mapping  ---------------------------------------------------- {{{

" Rebind <Leader> key.
let g:mapleader = ','
noremap \ ,

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
" Reset space-tab
nnoremap <leader>re :set tabstop=4 softtabstop=4 shiftwidth=4 expandtab<CR>:retab<CR>

" swicth to last file edited
nnoremap <leader><leader> <c-^>

" Easy subsitute providing a previous pattern
nnoremap <leader>; :%s:::cg<Left><Left><Left>

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
let g:syntastic_python_flake8_args='--ignore=E303,E301,E261,E721,E126 --max-line-length=84'
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
" Ack on <leader>a
nnoremap <leader>a :Ack<space>
let g:ackprg = 'ag --nogroup --nocolor --column'
let g:ackhighlight = 1
let g:ack_autofold_results = 1
let g:ackpreview = 1

" Vimux settings
 " Prompt for a command to run
 nnoremap <Leader>cc :VimuxPromptCommand<CR>
 " Run last command executed by VimuxRunCommand
 nnoremap <Leader>cu :VimuxRunLastCommand<CR>

" Settings for Gundo
nnoremap <leader>g :GundoToggle<CR>

"Settings for Ctrlp
set wildignore+=*.pyc
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ -g ""'
" let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" ------------------------------------------------------------------------ }}}
