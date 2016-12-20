"###############################################################################
"# Bootstrap
"###############################################################################

" Vim doesn't like fish
set shell=/bin/bash

" be iMproved
set nocompatible

" UTF-8 all the things
set fileencoding=utf-8

"###############################################################################
"# Plugins
"###############################################################################

call plug#begin()

Plug 'NLKNguyen/papercolor-theme'
Plug 'Raimondi/delimitMate'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color'
Plug 'editorconfig/editorconfig-vim'
Plug 'flowtype/vim-flow'
Plug 'jparise/vim-graphql'
Plug 'mhartington/deoplete-typescript'
Plug 'mileszs/ack.vim'
Plug 'neomake/neomake'
Plug 'pbrisbin/vim-mkdir'
Plug 'sheerun/vim-polyglot'
Plug 'steelsojka/deoplete-flow'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'wakatime/vim-wakatime'
Plug 'wincent/command-t', {'do': 'cd ruby/command-t; ruby extconf.rb; make'}
Plug 'wincent/ferret'

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

" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css,scss setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,xhtml,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript,jsx setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

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

" Uses The Silver Searcher for grepping if available
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Start search with Command-T on active buffers
nnoremap <leader>b :CommandTBuffer<CR>

" Split snippet edit panels vertically by default
let g:UltiSnipsEditSplit='vertical'

" Plugin extractable
let g:deoplete#enable_at_startup = 1
let g:deoplete#file#enable_buffer_path = 1

" All linting errors show be bullets
let g:neomake_error_sign = {'text': '•', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': '•', 'texthl': 'NeomakeWarningSign'}

" Prettier linting errors
hi NeomakeErrorSign ctermfg=124 cterm=bold
hi NeomakeWarningSign ctermfg=31 cterm=bold

" Linting with Neomake
let g:neomake_highlight_columns = 0

" Disable Flow linting through FB's plugin, delegate this to Neomake instead
let g:flow#enable = 0

" Trigger linter whenever saving/reading a file
augroup NeomakeLinter
  autocmd!
  autocmd BufWritePost,BufReadPost * Neomake
augroup end

"###############################################################################
"# Project specific Vim configuration
"###############################################################################

set exrc
set secure
