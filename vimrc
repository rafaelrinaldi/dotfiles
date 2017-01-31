" be iMproved
set nocompatible

" UTF-8 all the things
set fileencoding=utf-8

" Plugins
" =============================================================================

call plug#begin()

Plug 'NLKNguyen/papercolor-theme'
Plug 'Raimondi/delimitMate'
" Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color'
" Plug 'carlitux/deoplete-ternjs', {'do': 'npm i tern -g'}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'sheerun/vim-polyglot'
" Plug 'steelsojka/deoplete-flow', {'do': ':UpdateRemotePlugins'}
" Plug 'ternjs/tern_for_vim', {'do': 'npm i'}
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
" Plug 'w0rp/ale'
Plug 'wakatime/vim-wakatime'

call plug#end()

" General settings
" =============================================================================

" Automatic plugin indent
filetype plugin indent on

" Line numbers
set number

" Relative numbers
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

" Complete files like a shell
set wildmenu wildmode=full

" Specify files to ignore on wildmenu
set wildignore+=.git,.svn
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.sw?
set wildignore+=.DS_Store
set wildignore+=node_modules

" Set highlight for search
set hlsearch

" Be smart when searching
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

" Show ruler
set ruler

" Save file when switching buffers
set autowriteall

" Omni completion menu options
set cot-=preview

" GUI
" =============================================================================

if has('gui_running')
  set guifont=Input\ Mono\ Regular:h16

  " Force a screen render when changing modes
  inoremap <special> <Esc> <Esc>hl

  " Fix the way cursor looks
  set guicursor+=i:blinkwait0

  " Remove scroll bars
  set guioptions-=T
  set guioptions-=R
  set guioptions-=L

  " Display the default tab style
  set guioptions-=e
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

" Remap the space key to toggle current fold
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
