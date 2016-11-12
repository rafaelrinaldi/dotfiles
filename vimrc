"###############################################################################
"# Bootstrap
"###############################################################################

" Vim doesn't like fish
set shell=/bin/bash

" be iMproved, required
set nocompatible

" UTF-8 all the things
set fileencoding=utf-8

"###############################################################################
"# Plugins
"###############################################################################

call plug#begin()

Plug '1995eaton/vim-better-javascript-completion'
Plug 'NLKNguyen/papercolor-theme'
Plug 'Raimondi/delimitMate'
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color'
Plug 'editorconfig/editorconfig-vim'
Plug 'mileszs/ack.vim'
Plug 'pbrisbin/vim-mkdir'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'wakatime/vim-wakatime'
Plug 'wincent/command-t', {'do': 'cd ruby/command-t; ruby extconf.rb; make'}

call plug#end()

"###############################################################################
"# General settings
"###############################################################################

" Automatic plugin indent
filetype plugin indent on

" Show line numbers
set number

" Numbers are relative to cursor
set relativenumber

" Set the title at top of tab to be the filename
set title

" Automatic syntax
syntax enable

" Tab
set tabstop=2 shiftwidth=2 expandtab

" Backspace
set backspace=2

" Display hidden whitespace
set listchars=tab:▸\ ,eol:¬,trail:·,nbsp:·
set showbreak=↪\

" Display hidden characters by default
set list

" Highlight current line
set cursorline

" Highlight column 80
set colorcolumn=80
set linebreak

" Give one virtual space at end of line
set virtualedit=onemore

" Complete files like a shell
set wildmenu wildmode=full

" Specify files to ignore on wildmenu
set wildignore+=.git,.svn
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.sw?
set wildignore+=.DS_Store
set wildignore+=node_modules,bower_components,elm-stuff

" Ignore patterns for netrw
let g:netrw_list_hide='.*\.git,.*\.DS_Store$'

" Set highlight for search
set hlsearch

" Case-insensitive searching
set ignorecase

" But case-sensitive if expression contains a capital letter
set smartcase

" Display status bar
set laststatus=2

" Vim backup files
set undofile
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp
set undodir=~/.vim/tmp

" Enable mouse in all modes because why not
set mouse=a

" Change the position where panes are opened
set splitbelow
set splitright

" Enable tree folding
set foldenable
set foldnestmax=10
set foldlevelstart=10
set foldmethod=indent

" Show ruler at all times
set ruler

" Omni completion menu options
set complete-=i
set complete-=t
set completeopt-=preview
set completeopt+=menu,menuone

au FileType html,xhtml setl ofu=htmlcomplete#CompleteTags
au FileType css,scss setl ofu=csscomplete#CompleteCSS
au FileType javascript setl ofu=javascriptcomplete#CompleteJS

" Save file when switching buffers
set autowriteall

"###############################################################################
"# Key mapping
"###############################################################################

" Remap the space key to toggle current fold
nnoremap <tab> za

"###############################################################################
"# File-type specific
"###############################################################################

function! s:setupWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=80
endfunction

" Make sure all markdown files have the correct filetype set and setup wrapping
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown | call s:setupWrapping()

" Fix folding on JSON and CSS files
autocmd Filetype json,css,scss setlocal foldmethod=syntax

" Limits the body of Git commit messages to 72 characters
autocmd Filetype gitcommit setlocal textwidth=72

" Enable spell checking on certain file types
autocmd BufRead,BufNewFile *.md,gitcommit setlocal spell complete+=kspell

" Auto save files when focus is lost
au FocusLost * silent! wa

" Some file types use real tabs
au FileType {make,gitconfig} setl noexpandtab

"###############################################################################
"# Theming
"###############################################################################

set background=light
colorscheme PaperColor

" Enable italic text
highlight Comment cterm=italic

" Display current line number in bold text
highlight CursorLineNr cterm=bold

"###############################################################################
"# Plugin specific
"###############################################################################

" Use Git's `ls-files` to actually ignore hidden files
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Remap most used CtrlP commands
nnoremap <leader>f :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>

" Split snippet edit panels vertically by default
let g:UltiSnipsEditSplit='vertical'

"###############################################################################
"# Misc
"###############################################################################

if has('termguicolors')
  if &term =~# 'tmux-256color'
    let &t_8f="\e[38;2;%ld;%ld;%ldm"
    let &t_8b="\e[48;2;%ld;%ld;%ldm"
  endif
endif

" Load local vimrc if available
if filereadable(glob("~/.vimrc.local")) 
  source ~/.vimrc.local
endif

"###############################################################################
"# Misc
"###############################################################################

" Load local vimrc if available
if filereadable(glob("~/.vimrc.local")) 
  source ~/.vimrc.local
endif
