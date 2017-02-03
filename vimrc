" be iMproved
set nocompatible

" UTF-8 all the things
set fileencoding=utf-8

" Plugins
" =============================================================================

call plug#begin()

Plug 'NLKNguyen/papercolor-theme'
Plug 'Raimondi/delimitMate'
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'wakatime/vim-wakatime'

" Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
" Plug 'carlitux/deoplete-ternjs', {'do': 'npm i tern -g'}
" Plug 'w0rp/ale'
" Plug 'steelsojka/deoplete-flow', {'do': ':UpdateRemotePlugins'}
" Plug 'ternjs/tern_for_vim', {'do': 'npm i'}

call plug#end()

" General settings
" =============================================================================

" Vim doesn't like Fish
set shell=/bin/bash

" Load plugins based on file type
filetype plugin indent on

" Enable syntax Highlighting
syntax on

" Set the title at top of tab to be the filename
set title

" Line numbers
set number relativenumber

" Set default tabs as two spaces
set expandtab softtabstop=2 shiftwidth=2 shiftround

" Backspace behaves as expected
set backspace=indent,eol,start

" Enable switching buffers before saving them
set hidden

" Display status bar
set laststatus=2

" Last commands auto completion
set showcmd

" Highlight while searching
set incsearch

" Highlight search keywords
set hlsearch

" Smart search case
set smartcase

" Change the position where new windows are opened
set splitbelow
set splitright

" Display hidden characters
set list
set listchars=tab:▸\ ,eol:¬,trail:·,nbsp:·
set showbreak=↪\

" Highlight current line
set cursorline

" Highlight column 80
set colorcolumn=80

" Complete files like a shell
set wildmenu wildmode=full

" Specify files to ignore on wildmenu
set wildignore+=.git,.svn
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.sw?
set wildignore+=.DS_Store
set wildignore+=node_modules

" Enable mouse in all modes because why not
set mouse=a

" Enable folding
set foldenable
set foldnestmax=10
set foldlevelstart=10
set foldmethod=indent

" Show ruler on status line
set ruler

" Save file when switching buffers
set autowriteall

" Omni completion menu options
set cot-=preview

" Vim backup files organized by context
set backup
set backupdir=$HOME/.vim/files/backup/
set backupskip=
set directory=$HOME/.vim/files/swap/
set updatecount=100
set undofile
set undodir=$HOME/.vim/files/undo/

" Always report changed lines
set report=0

" Only redraw when necessary
set lazyredraw

" Only highlight first 200 columns
set synmaxcol=200

" GUI
" =============================================================================

if has('gui_running')
  set guifont=Input\ Mono:h16

  " Force render when switching modes
  inoremap <special> <Esc> <Esc>hl

  " Remove scroll bars
  set guioptions-=T
  set guioptions-=R
  set guioptions-=L

  " Display the default tab style
  set guioptions-=e

  set ttyfast
endif

" Neovim
" =============================================================================

if has('nvim')
  " Automatically see commands and their output as you type
  set inccommand=split

  " Enable Neovim support for true terminal colors
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1

  " Leave TERMINAL mode when hitting escape, as expected
  tnoremap <esc> <C-\><C-n>
endif

" Mappings
" =============================================================================

" Remap the tab key to toggle current fold
nnoremap <tab> za

" Search for files
nnoremap <leader>t :CtrlP<CR>

" Search for buffers
nnoremap <leader>b :CtrlPBuffer<CR>

" File specific
" =============================================================================

" Limits the body of Git commit messages to 72 characters
autocmd FileType gitcommit set textwidth=72

" Enable spell checking on certain file types
autocmd FileType {markdown,gitcommit} set spell complete+=kspell

" Set syntax highlighting for specific file types
autocmd BufRead,BufNewFile *.eslintrc set filetype=json

" Some file types use hard tabs
autocmd FileType {make,gitconfig} set noexpandtab

" Make `gf` work properly
autocmd FileType {javascript.jsx} set suffixesadd+='.js,.jsx'

" Setup prettier if available
if executable('prettier')
  autocmd FileType {javascript.jsx} set formatprg=prettier\ --single-quote\ --trailing-comma\ --no-bracket-spacing\ --stdin
endif

" Events
" =============================================================================

" Autotically save files on focus change
autocmd FocusLost,BufLeave * silent! w

" Theming
" =============================================================================

set background=light
colorscheme PaperColor

" Enable italic text
highlight Comment cterm=italic

" Display current line number in bold text
highlight CursorLineNr cterm=bold

" Auto completion
" =============================================================================

" Enable built in omni completion
augroup omnifuncs
  autocmd!
  autocmd FileType css,scss setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,xhtml,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_refresh_always = 1

" Tern
let g:tern_request_timeout = 1
let g:tern#arguments = ['--persistent']

" Linting
" =============================================================================

" Prettier linting errors
highlight ALEErrorSign ctermfg=124 cterm=bold
highlight ALEWarningSign ctermfg=31 cterm=bold

" Custom linting symbols
let g:ale_sign_error = '●'
let g:ale_sign_warning = '●'

" File navigation
" =============================================================================

" Use ripgrep over Grep
if executable('rg')
  set grepprg=rg\ --vimgrep

  " Apply `.gitignore` rules and pipe filtered results to ripgrep
  let g:ctrlp_user_command = ['.git', 'cd %s; rg --files-with-matches ".*"', 'find %s -type f']
  let g:ctrlp_use_caching = 0

  " Simple command to populate the quickfix list with match results
  if !exists(':Find')
    command -nargs=+ -complete=file -bar Find silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Find<SPACE>
  endif
endif

" Misc
" =============================================================================

" Load config per project if `.lvimrc` is present
if filereadable($PWD .'/.lvimrc')
  source ./.lvimrc
endif
