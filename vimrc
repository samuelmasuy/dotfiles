" vim:fdm=marker
" Author: Samuel Masuy and the vim community.

" set noro
" To make a portable tar vim:
" bash <(curl -L https://raw.githubusercontent.com/junegunn/myvim/master/myvim)

" Tip Macros: important!!!
" "ap: put (print) content of macro in register a.
" "ayy: put back current line in register a (macro).
" switch to last file edited: <leader><leader>
" switch to last place edited: ''
" open vinegar in current Directory!!!: -
" <C-o> in insert mode is awesome

" Pre vim  --------------------------------------------------------------- {{{

" Automatic reloading of vimrc
autocmd! bufwritepost $MYVIMRC source $MYVIMRC

if has('nvim')
	call plug#begin('~/.config/nvim/plugged')
	Plug 'Shougo/deoplete.nvim'
	Plug 'zchee/deoplete-go', { 'do': 'make'}
	Plug 'mhartington/deoplete-typescript', {'for': ['typescript']}
	Plug 'carlitux/deoplete-ternjs', {'for': ['javascript']}
	Plug 'ternjs/tern_for_vim', { 'do': 'npm install', 'for': ['javascript']}
	Plug 'zchee/deoplete-jedi', {'for': ['python']}
	Plug 'mhartington/oceanic-next'
	Plug 'rakr/vim-two-firewatch'
	" set background=dark " or light if you prefer the light version
	" let g:two_firewatch_italics=1
	" colo two-firewatch
	" let g:airline_theme='twofirewatch'
else
	call plug#begin('~/.vim/plugged')
	Plug 'Shougo/neocomplete.vim'
endif

" Essential
Plug 'morhetz/gruvbox'
Plug 'fatih/vim-go', {'for': ['go']}
Plug 'benekastah/neomake'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch' " Adds Unix commands to vim.
Plug 'tpope/vim-surround' " To change surrounding quote: cs(' ;tag cst<th> ;to add quote ysW'
Plug 'tpope/vim-vinegar' " Enhance of netrw

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'

Plug 'tmux-plugins/vim-tmux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
Plug 'EinfachToll/DidYouMean'
Plug 'mhinz/vim-startify'
Plug 'Valloric/MatchTagAlways'
Plug 'Valloric/ListToggle'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim', {'for': ['typescript']}
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'quramy/tsuquyomi'
Plug 'magarcia/vim-angular2-snippets'

Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'ujihisa/unite-colorscheme'
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/unite-outline'
Plug 'Shougo/unite-help'
Plug 'mackee/unite-httpstatus'
" Plug 'maksimr/vim-jsbeautify', {'for': ['javascript', 'css', 'html']} " Provide beatify for html, js, css
" npm -g install js-beautify instead
"
Plug 'davidhalter/jedi-vim', {'for': ['python']} " !Important when using python
Plug 'vim-scripts/DirDiff.vim' " :DirDiff <A:Src Directory> <B:Src Directory>
Plug 'ekalinin/Dockerfile.vim', {'for' : 'Dockerfile'}
Plug 'bronson/vim-trailing-whitespace'

Plug 'junegunn/vim-peekaboo'

call plug#end()

" Better copy & paste.
if has('mac')
	set clipboard=unnamed
elseif has('unix') && (executable('pbcopy') || executable('xclip') || executable('xsel')) && has('clipboard')
	set clipboard+=unnamedplus
endif
" See the commands typed in the right bottom corner.
set showcmd
if !has('nvim')
	" Make backspace behave like normal.
	set bs=2
	" Auto Indent
	set autoindent
endif

filetype plugin indent on

" ------------------------------------------------------------------------ }}}
" Appearance  ------------------------------------------------------------ {{{
" Enable syntax highlighting.
syntax on

" Beautiful
if has('nvim') && has("termguicolors")
		silent! colorscheme OceanicNext
		set termguicolors
else
	set t_Co=256
	silent! colorscheme gruvbox
	let g:gruvbox_italicize_comments=0
endif

set background=dark

" ------------------------------------------------------------------------ }}}
" Miscellaneous settings ------------------------------------------------- {{{

if has('nvim')
	let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
endif
" Show the line that have been wrapped.
let &showbreak='↪ '
" Gdiff vertical split
set diffopt+=vertical
" Completion options (select longest + show menu even if a single match is found)
set completeopt=longest,menuone
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
" Automatically reread changed files without asking me anything
set autoread
" speed up syntax highlighting
set nocursorcolumn
set nocursorline

" Colorize the 100th column if goes over.
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%101v', 100)

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

if !has('nvim')
	" Useful settings.
	set history=700
	" Make search case insensitive.
	set hlsearch
	set incsearch
	" Tab-completion options.
	set wildmenu
endif

" How many undos
set undolevels=1000
" Undo file
set undodir=~/.config/nvim/undos
set undofile

set ignorecase
set smartcase

" Wildmode aka tab-completion options.
set wildmode=full

" for argdo and bufdo without a trailing bang.
set hidden

" Disable backup and swap files.
set nobackup
set nowritebackup
set noswapfile

" ------------------------------------------------------------------------ }}}
" General Mapping  ------------------------------------------------------- {{{

cnoremap wq :echo 'Use ZZ'<CR>

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

" Make sure to be in the middle of the screen when searching.
nnoremap n nzzzv
nnoremap N Nzzzv

" Easier indentation of code blocks.
vnoremap < <gv
vnoremap > >gv

" basic, why not before
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" logical
nnoremap Y y$

" Switch marks
nnoremap ' `
nnoremap ` '

nnoremap <leader>dup :diffupdate<CR>

" Don't move on *
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

if has('nvim')
	" Terminal mode
	tnoremap <Esc> <C-\><C-n>
	tnoremap <C-h> <C-\><C-n><C-w>h
	tnoremap <C-j> <C-\><C-n><C-w>j
	tnoremap <C-k> <C-\><C-n><C-w>k
	tnoremap <C-l> <C-\><C-n><C-w>l
endif

" ------------------------------------------------------------------------ }}}
" Syntax support  -------------------------------------------------------- {{{
" python
" ------
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 formatoptions=croqj softtabstop=4 comments=:#\:,:#
autocmd FileType python nnoremap <leader>y :0,$!yapf<Cr>
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
let python_highlight_all=1
let python_slow_sync=1
let g:neomake_python_flake8_maker = {
			\ 'args': [
					\ '--ignore=E121,E124,E126,E261,E301,E303,E501,E721',
					\ '--max-line-length=104']
		\ }
" Don't warn on
"   E121 continuation line indentation is not a multiple of four
"   E124 closing bracket does not match visual indentation
"   E126 continuation line over-indented for hanging indent
"   E128 continuation line under-indented for visual indent
"   E261 at least two spaces before inline comment
"   E301 expected 1 blank line, found 0
"   E303 expected 2 blank lines, found <n>
"   E721 do not compare types, use 'isinstance()'
let g:neomake_python_enabled_makers = ['flake8', 'python']
autocmd BufLeave *.py               normal! mP

" Go
" ----------
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>i <Plug>(go-info)
autocmd FileType go nmap <leader>ii <Plug>(go-implements)
autocmd FileType go nmap <leader>re <Plug>(go-rename)
autocmd FileType go nmap <leader>ref <Plug>(go-referrers)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <leader>d <Plug>(go-def)
autocmd FileType go nmap <leader>de <Plug>(go-describe)
autocmd FileType go nmap K <Plug>(go-doc)
autocmd FileType go setlocal noexpandtab shiftwidth=4 tabstop=4 softtabstop=4
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1

let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0

let g:go_autodetect_gopath = 1
let g:go_fmt_fail_silently = 0
let g:go_fmt_command = "goimports"
let g:go_snippet_engine = "neosnippet"
let g:neomake_go_enabled_makers = ['go', 'govet']
autocmd BufLeave *.go             normal! mG

" Javascript
" ----------
autocmd FileType javascript setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType javascript setlocal commentstring=//\ %s
autocmd FileType javascript noremap <buffer> <leader>r :%!js-beautify --type js -j -q -B -f -<CR>
autocmd FileType javascript let b:javascript_fold = 0
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
let g:tern_map_keys = 0
autocmd FileType javascript nmap <leader>d :TernDef<CR>
autocmd FileType javascript nmap <leader>ref :TernRefs<CR>
autocmd FileType javascript nmap <leader>re :TernRename<CR>
autocmd FileType javascript nmap <leader>td :TernDoc<CR>
let javascript_enable_domhtmlcss=1
let g:neomake_javascript_enabled_makers = ['jshint']
autocmd BufLeave *.js             normal! mJ

" Typescript
" ----------
autocmd FileType typescript setlocal completeopt+=menu,preview
autocmd FileType typescript setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType typescript nmap <leader>d <Plug>(TsuquyomiDefinition)
autocmd FileType typescript nmap <leader>ref <Plug>(TsuquyomiReferences)
autocmd FileType typescript nmap <leader>re <Plug>(TsuquyomiRenameSymbolC)
autocmd FileType typescript nmap <leader>im <Plug>(TsuquyomiImport)
autocmd FileType typescript noremap <buffer> <leader>r :%!js-beautify --type typescript -j -q -B -f -<CR>
autocmd FileType typescript nmap <buffer> <Leader>T : <C-u>echo tsuquyomi#hint()<CR>
autocmd BufLeave *.ts             normal! mT

" ruby
" ----
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" php
" ---
autocmd FileType php setlocal shiftwidth=4 tabstop=8 softtabstop=4 expandtab

" Template language (SGML / XML too)
" ----------------------------------
autocmd FileType xml,html,htmljinja,htmldjango setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType html setlocal commentstring=<!--\ %s\ -->
autocmd FileType htmljinja setlocal commentstring={#\ %s\ #}
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
let html_no_rendering=1
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType html noremap <buffer> <leader>r :%!js-beautify --type html -j -q -B -f -<CR>
autocmd BufLeave *.html             normal! mH

" CSS
" ---
autocmd FileType css,scss setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType css,scss setlocal commentstring=/*\ %s\ */
autocmd FileType css,scss noremap <buffer> <leader>r :%!js-beautify --type css -j -q -B -f -<CR>
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd BufLeave *.css,*.less,*scss normal! mC

" Java
" ----
autocmd FileType java setlocal shiftwidth=2 tabstop=8 softtabstop=2 expandtab
autocmd FileType java setlocal commentstring=//\ %s

" rst
" ---
autocmd BufNewFile,BufRead *.txt setlocal ft=rst
autocmd FileType rst setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 formatoptions+=nqt
" md
" ---
autocmd FileType md setlocal noexpandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType markdown setlocal noexpandtab shiftwidth=4 tabstop=4 softtabstop=4

" C/Obj-C/C++
autocmd FileType c setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType cpp setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType objc setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType c setlocal commentstring=/*\ %s\ */
autocmd FileType cpp,objc setlocal commentstring=//\ %s
let c_no_curly_error=1

" vim
" ---
autocmd FileType vim setlocal noexpandtab shiftwidth=2 tabstop=2 softtabstop=2

" JSON
" ----
autocmd FileType json setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType json noremap <buffer> <leader>r :%!js-beautify --type js -j -q -B -f -<CR>

" ------------------------------------------------------------------------ }}}
" Leader Key Mapping  ---------------------------------------------------- {{{

" Rebind <leader> key.
let g:mapleader = ','
noremap \ ,

" Open in a new tab .vimrc
nnoremap <leader>e :tabedit $MYVIMRC<CR>
" Remap visual block select.
nnoremap <leader>v <c-v>
"Open new vertical split
nnoremap <leader>vs :vsplit<CR>
" Map sort function to a key
vnoremap <leader>s :sort<CR>
" Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>
" Reset space-tab
nnoremap <leader>reta :retab<CR>

" cd to where the file is currently located
nnoremap <leader>. :lcd %:p:h<CR>

" switch to last file edited
nnoremap <leader><leader> <c-^>

" Google search word under cursor from http://www.vimbits.com/bits/551
nnoremap <leader>is :let @p=@"<cr>yiw:!open "https://www.google.com/search?q=""<cr><cr>
    \:let @"=@p<cr>
" Google search the definition of the word under cursor
nnoremap <leader>id :let @p=@"<cr>yiw:!open "https://www.google.com/search?q=define ""<cr><cr>
    \:let @"=@p<cr>

" Easy substitute providing a previous pattern
nnoremap <leader>; :%s::cg<Left><Left><Left>
vnoremap <leader>; :s::g<Left><Left>

" ------------------------------------------------------------------------ }}}
" Plugins setup. --------------------------------------------------------- {{{
" Settings for vim-airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'powerlineish'
" let g:airline_theme = 'oceanicnext'
set laststatus=2
let g:airline#extensions#whitespace#checks = []

" Settings for neomake
autocmd! BufWritePost * Neomake " run neomake on file write
let g:neomake_verbose = 0
hi NeoErrorMsg ctermfg=88
let g:neomake_error_sign = {'text': '✘', 'texthl': 'NeoErrorMsg'}
hi NeoWarningMsg ctermfg=136
let g:neomake_warning_sign = {'text': '⚠', 'texthl': 'NeoWarningMsg'}

" Settings for jedi-vim
" let g:jedi#popup_select_first = 0

" Settings for Ack.vim
" Ack on <leader>a
nnoremap <leader>a :Ack<space>
let g:ackprg = 'ag --nogroup --nocolor --column'
let g:ackhighlight = 1
let g:ack_autofold_results = 1
let g:ackpreview = 1

" Vimux settings
 " Prompt for a command to run
 nnoremap <leader>cc :VimuxPromptCommand<CR>
 " Run last command executed by VimuxRunCommand
 nnoremap <leader>cu :VimuxRunLastCommand<CR>


" Settings for sayonara
nnoremap <silent> gs :Sayonara<CR>
nnoremap <silent> gS :Sayonara!<CR>

" Settings for ListToggle
let g:lt_quickfix_list_toggle_map = '<leader>fix'

" Unite settings
" nnoremap <C-i> :Unite file_rec/async<cr>
let g:unite_source_history_yank_enable=1
let g:unite_prompt='❯ '
let g:unite_source_rec_async_command =['ag', '--follow', '--nocolor', '--nogroup','--hidden', '-g', '', '--ignore', '.git', '--ignore', '*.png', '--ignore', 'lib']
if has('nvim')
	nnoremap <silent> <C-p> :Unite -start-insert -vertical -direction=botright buffer file_mru file_rec/neovim<CR>
	" nnoremap <C-p> :Unite buffer file_mru file_rec -no-split -start-insert<CR>
	nnoremap <silent> <leader>c :Unite -auto-resize -start-insert -direction=botright colorscheme<CR>

	nnoremap <silent> <leader>st :Unite -winwidth=45 -vertical -direction=botright httpstatus<CR>

	nnoremap <silent> <leader>o :Unite -winwidth=45 -vertical -direction=botright outline<CR>
	" Custom mappings for the unite buffer
	autocmd FileType unite call s:unite_settings()
	function! s:unite_settings()
		" Enable navigation with control-j and control-k in insert mode
		imap <buffer> <C-j>   <Plug>(unite_select_next_line)
		imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
	endfunction

  let g:unite_source_menu_menus = {} " Useful when building interfaces at appropriate places
  let g:unite_source_menu_menus.git = {'description' : 'Fugitive interface',}
  let g:unite_source_menu_menus.git.command_candidates = [
    \[' git status', 'Gstatus'],
    \[' git diff', 'Gvdiff'],
    \[' git commit', 'Gcommit'],
    \[' git stage/add', 'Gwrite'],
    \[' git checkout', 'Gread'],
    \[' git rm', 'Gremove'],
    \[' git cd', 'Gcd'],
    \[' git push', 'exe "Git! push " input("remote/branch: ")'],
    \[' git pull', 'exe "Git! pull " input("remote/branch: ")'],
    \[' git pull rebase', 'exe "Git! pull --rebase " input("branch: ")'],
    \[' git checkout branch', 'exe "Git! checkout " input("branch: ")'],
    \[' git fetch', 'Gfetch'],
    \[' git merge', 'Gmerge'],
    \[' git browse', 'Gbrowse'],
    \[' git head', 'Gedit HEAD^'],
    \[' git parent', 'edit %:h'],
    \[' git log commit buffers', 'Glog --'],
    \[' git log current file', 'Glog -- %'],
    \[' git log last n commits', 'exe "Glog -" input("num: ")'],
    \[' git log first n commits', 'exe "Glog --reverse -" input("num: ")'],
    \[' git log until date', 'exe "Glog --until=" input("day: ")'],
    \[' git log grep commits',  'exe "Glog --grep= " input("string: ")'],
    \[' git log pickaxe',  'exe "Glog -S" input("string: ")'],
    \[' git index', 'exe "Gedit " input("branchname\:filename: ")'],
    \[' git mv', 'exe "Gmove " input("destination: ")'],
    \[' git grep',  'exe "Ggrep " input("string: ")'],
    \[' git prompt', 'exe "Git! " input("command: ")'],
    \] " Append ' --' after log to get commit info commit buffers
  nnoremap <silent> <Leader>g :Unite -direction=botright -silent -buffer-name=git -start-insert menu:git<CR>
else
  nnoremap <C-p> :Unite buffer file_mru file_rec -no-split -start-insert<CR>
endif

if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
endif

" File preview using CodeRay (http://coderay.rubychan.de/) sudo gem install coderay
let g:fzf_files_options =
  \ '--preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'

nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <silent> <Leader>C        :Colors<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>ag       :Ag
nnoremap <silent> <Leader>`        :Marks<CR>

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" ------------------------------------------------------------------------ }}}
" Settings for (neocomplete and deoplete) and neosnippet ---------------------------- {{{
if has('nvim')
  " Deoplete
  let g:deoplete#enable_at_startup = 1

  " Use smartcase.
  let g:deoplete#enable_smart_case = 1

  " Set minimum syntax keyword length.
  let g:deoplete#auto_completion_start_length = 1
  let g:deoplete#sources#syntax#min_keyword_length = 2

	if !exists('g:deoplete#force_omni_input_patterns')
		let g:deoplete#force_omni_input_patterns = {}
	endif
  let g:deoplete#force_omni_input_patterns.typescript = '[^. \t]\.\%(\h\w*\)\?' " Same as JavaScript

  let g:deoplete#sources#tss#javascript_support = 1

  " Close popup by <Space>.
  inoremap <expr><C-x> pumvisible() ? deoplete#mappings#close_popup() : "\<Space>"

  " Neosnippet
  " SuperTab like snippets' behavior.
  imap <expr><CR> pumvisible() ?
  \(neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" : deoplete#mappings#close_popup())
  \: "\<CR>"
  imap <expr><TAB> neosnippet#jumpable() ?
  \ "\<Plug>(neosnippet_jump)"
  \: pumvisible() ? "\<C-n>" : "\<TAB>"
  let g:neosnippet#snippets_directory='~/.config/nvim/plugged/vim-go/gosnippets/snippets, ~/.config/nvim/plugged/neosnippet-snippets/neosnippets, ~/.config/nvim/plugged/vim-angular2-snippets/snippets'
	let g:neomake_python_enabled_makers = ['flake8', 'python']

  " let g:tern_request_timeout = 1
  if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
  endif

  let g:tern_request_timeout = 1
  " let g:tern_show_signature_in_pum = 0  " This do disable full signature type on autocomplete

  let g:tern#command = ['tern']
  let g:tern#arguments = ['--persistent', '--no-port-file']
else
  " Neocomplete

  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1

  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1

  " Set minimum syntax keyword length.
  let g:neocomplete#auto_completion_start_length = 1
  let g:neocomplete#sources#syntax#min_keyword_length = 2

  if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif
  " let g:neocomplete#force_omni_input_patterns.typescript = '[^. *\t]\.\w*\|\h\w*::'
  let g:neocomplete#force_omni_input_patterns.typescript = '[^. \t]\.\%(\h\w*\)\?' " Same as JavaScript

  " Close popup by <Space>.
  inoremap <expr><C-x> pumvisible() ? neocomplete#close_popup() : "\<Space>"

  " Neosnippet
  " SuperTab like snippets' behavior.
  imap <expr><CR> pumvisible() ?
  \(neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" : neocomplete#close_popup())
  \: "\<CR>"

  imap <expr><TAB> neosnippet#jumpable() ?
  \ "\<Plug>(neosnippet_jump)"
  \: pumvisible() ? "\<C-n>" : "\<TAB>"
  let g:neosnippet#snippets_directory='~/.vim/plugged/vim-go/gosnippets/snippets, ~/.vim/plugged/neosnippet-snippets/neosnippets'
endif

" ------------------------------------------------------------------------ }}}
