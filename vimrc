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
Plug 'junegunn/goyo.vim'
Plug 'junegunn/seoul256.vim'
Plug 'maralla/completor.vim', { 'do': 'make js' }
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
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

" GUI
" =============================================================================

if has('gui_running')
  set guifont=Input\ Mono\ Narrow:h15

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

" Map location list open to resemble VSCode
nnoremap <leader>m :lopen<CR>

" Enter "zen" mode
nnoremap <leader>f :Goyo<CR>

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

fun! s:light()
  set background=light
  colorscheme PaperColor
  highlight CursorLineNr ctermbg=254
endfun

fun! s:dark()
  set background=dark
  colorscheme seoul256
endfun

fun! s:styles()
  highlight Comment cterm=italic
  highlight CursorLineNr cterm=bold
endfun

fun! s:theme(theme)
  if a:theme == 0
    call s:dark()
  else
    call s:light()
  endif

  call s:styles()
endfun

if !exists(':ThemeDark')
  command -nargs=0 ThemeDark call s:theme(0)
endif

if !exists(':ThemeLight')
  command -nargs=0 ThemeLight call s:theme(1)
endif

exec 'ThemeDark'

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

" Completor
let g:completor_css_omni_trigger = '([\w-]+|@[\w-]*|[\w-]+:\s*[\w-]*)$'

" Linting
" =============================================================================

" Prettier linting errors
highlight ALEErrorSign ctermfg=125 cterm=bold
highlight ALEWarningSign ctermfg=220 cterm=bold

" Custom linting symbols
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1
let g:ale_sign_error = '●'
let g:ale_sign_warning = '●'

" Goyo (zen mode)
" =============================================================================

let g:goyo_height = '95%'

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

" Misc
" =============================================================================

" Load config per project if `.lvimrc` is present
if filereadable($PWD .'/.lvimrc')
  source ./.lvimrc
endif
