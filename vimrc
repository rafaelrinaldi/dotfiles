" be iMproved
set nocompatible

" UTF-8 all the things
set fileencoding=utf-8

" Plugins
" =============================================================================

call plug#begin()

Plug 'NLKNguyen/papercolor-theme'
Plug 'Raimondi/delimitMate'
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color'
Plug 'carlitux/deoplete-ternjs', {'do': 'yarn global add tern --prefix /usr/local'}
Plug 'editorconfig/editorconfig-vim'
Plug 'mhartington/deoplete-typescript', {'do': ':UpdateRemotePlugins'}
Plug 'mileszs/ack.vim'
Plug 'pbrisbin/vim-mkdir'
Plug 'sheerun/vim-polyglot'
Plug 'steelsojka/deoplete-flow', {'do': ':UpdateRemotePlugins'}
Plug 'ternjs/tern_for_vim', {'do': 'npm install'}
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'w0rp/ale'
Plug 'wakatime/vim-wakatime'
Plug 'wincent/command-t', {'do': 'cd ruby/command-t; ruby extconf.rb; make'}

call plug#end()

" General settings
" =============================================================================

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
let g:netrw_list_hide='.*\.git,.*\.DS_Store,.\/node_modules$'

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

" Show ruler
set ruler

" Save file when switching buffers
set autowriteall

" Omni completion menu options
set cot-=preview

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

" Trigger CommandT
nnoremap <leader>t :CommandT<CR>

" Start search with Command-T on active buffers
nnoremap <leader>b :CommandTBuffer<CR>

" File specific
" =============================================================================

" Limits the body of Git commit messages to 72 characters
autocmd FileType gitcommit set textwidth=72

" Enable spell checking on certain file types
autocmd FileType {markdown,gitcommit} set spell complete+=kspell

" Set syntax highlighting for specific file types
autocmd BufRead,BufNewFile *.eslintrc set filetype=json
autocmd BufRead,BufNewFile *.tsx set filetype=typescript

" Some file types use hard tabs
autocmd FileType {make,gitconfig} set noexpandtab

" Make `gf` work properly
autocmd FileType {javascript,jsx,javascript.jsx} set suffixesadd+='.js,.jsx'
autocmd FileType {typescript} set suffixesadd+='.ts,.tsx'

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

" Uses ripgrep for fastest possible grepping (if available)
if executable('rg')
  " Point binary to Vim
  set grepprg=rg\ --vimgrep

  " Point binary to Ack
  let g:ackprg = 'rg --vimgrep'
endif

" Misc
" =============================================================================

" Load config per project if `.lvimrc` is present
if filereadable(glob('./.lvimrc'))
  source ./.lvimrc
endif
