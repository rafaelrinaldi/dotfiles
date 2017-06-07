" be iMproved
set nocompatible

" UTF-8 all the things
set fileencoding=utf-8

" Plugins
" =============================================================================

call plug#begin()

Plug 'Raimondi/delimitMate'
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'ervandew/supertab'
Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'junegunn/goyo.vim'
Plug 'junegunn/rainbow_parentheses.vim', { 'for': 'clojure' }
Plug 'junegunn/seoul256.vim'
Plug 'maralla/completor.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-salve'
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'venantius/vim-cljfmt', { 'for': 'clojure' }
Plug 'w0rp/ale'
Plug 'wakatime/vim-wakatime'

call plug#end()

" General settings
" =============================================================================

" Vim doesn't like Fish
set shell=/bin/bash

" Load plugins based on file type
filetype plugin indent on

" Enable syntax Highlighting
syntax on

" Use backspace as leader
let mapleader = "\<BS>"

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
set listchars=tab:▸\ ,trail:·,nbsp:·
set showbreak=↪\

" Highlight current line
set cursorline

" Highlight column 80
set colorcolumn=80

" Complete files like a shell
set wildmenu wildmode=full
set completeopt=longest,menuone

" Specify files to ignore on wildmenu
set wildignore+=.git/
set wildignore+=*.jpe?g,*.bmp,*.gif,*.png
set wildignore+=*.sw?
set wildignore+=.DS_Store
set wildignore+=node_modules/
set wildignore+=*.lock

" Enable folding
set foldenable
set foldnestmax=10
set foldlevelstart=10
set foldmethod=indent

" Show ruler on status line
set ruler

" Save file when switching buffers
set autowrite
set autoread

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

" Enable mouse
set mouse=a

" Keyboard mappings
" =============================================================================

vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" GUI
" =============================================================================

if has('gui_running')
  set guifont=Iosevka\ Slab:h17

  " Don't blink the cursor
  set guicursor+=n-v-i:blinkon0
  set guicursor+=n-v-i:blinkwait0

  " Remove scroll bars
  set guioptions-=t
  set guioptions-=r
  set guioptions-=L

  " Display the default tab style
  set guioptions-=e

  " Better line height
  set linespace=1

  set macligatures
  set ttyfast

  " Force render when switching modes
  inoremap <special> <Esc> <Esc>hl
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
nnoremap <Space> za

" Search for files
nnoremap <Leader>t :CtrlP<CR>

" Search for buffers
nnoremap <Leader>b :CtrlPBuffer<CR>

" Bring up the QuickFix list
nnoremap <Leader>q :copen<CR>

" Bring up the location list
nnoremap <Leader>l :lopen<CR>

" Enter "zen" mode
nnoremap <Leader>f :Goyo<CR>

" File specific
" =============================================================================

" Limits the body of Git commit messages to 72 characters
autocmd FileType gitcommit set textwidth=72

" Enable spell checking on certain file types
autocmd FileType {markdown,gitcommit} set spell complete+=kspell

" Set syntax highlighting for specific file types
autocmd BufRead,BufNewFile *.{eslint,babel}rc set filetype=json

" Some file types use hard tabs
autocmd FileType {make,gitconfig} set noexpandtab

" Make `gf` work properly for JavaScript files
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

set background=dark

if has('gui_running')
  " Make sure colorscheme looks consistent on GUI
  let g:seoul256_background = 236
endif

colorscheme seoul256

highlight Comment cterm=italic gui=italic
highlight CursorLineNr cterm=bold gui=bold

" Auto completion
" =============================================================================

" Enable built in omni completion
augroup omnifuncs
  autocmd!
  autocmd FileType css,scss setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,xhtml,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript.jsx setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

" Linting
" =============================================================================

" Prettier linting errors
highlight ALEErrorSign cterm=bold
highlight ALEWarningSign cterm=bold

" Custom linting symbols
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_sign_error = '●'
let g:ale_sign_warning = '●'

" Goyo (zen mode)
" =============================================================================

let g:goyo_height = '95%'

" Git Gutter
" =============================================================================

let g:gitgutter_override_sign_column_highlight = 0

" File navigation
" =============================================================================

" Use ripgrep instead of Grep
if executable('rg')
  set grepprg=rg\ --vimgrep

  " Apply `.gitignore` rules and pipe filtered results to ripgrep
  let g:ctrlp_user_command = ['.git', 'cd %s; rg --files-with-matches ".*"', 'find %s -type f']
  let g:ctrlp_use_caching = 0

  " Simple command to populate the quickfix list with match results
  if !exists(':Find')
    command -nargs=+ -complete=file -bar Find silent! grep! <args>|cwindow|redraw!
  endif
endif

" Completor
" =============================================================================

" Enable CSS completion
let g:completor_css_omni_trigger = '([\w-]+|@[\w-]*|[\w-]+:\s*[\w-]*)$'

" SuperTab
" =============================================================================

let g:SuperTabDefaultCompletionType = '<c-n>'

" Clojure
" =============================================================================

augroup clojure
  autocmd!
  autocmd FileType clojure RainbowParentheses
  autocmd FileType clojure setlocal commentstring=;;\ %s
  autocmd Filetype clojure nnoremap <Leader>r :Require<CR>
augroup end

" So `salve.vim` attempts to make a REPL connection automatically
let g:salve_auto_start_repl = 1

" Misc
" =============================================================================

" Load config per project if `.lvimrc` is present
if filereadable($PWD .'/.lvimrc')
  source ./.lvimrc
endif
