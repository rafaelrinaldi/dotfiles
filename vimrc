"###############################################################################
"# Bootstrap
"###############################################################################

" Vim doesn't like fish
set shell=/bin/bash

" be iMproved, required
set nocompatible

" UTF-8 all the things
set encoding=utf-8
set fileencoding=utf-8

" Remove automatic plugin identation (required by Vundle)
filetype off

"###############################################################################
"# Vundle
"###############################################################################

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

" Startup Vundle
call vundle#begin()

"###############################################################################
"# Plugins
"###############################################################################

" Let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" Emmet
Plugin 'mattn/emmet-vim'

" Editor config
Plugin 'editorconfig/editorconfig-vim'

" Solarized color scheme
Plugin 'altercation/vim-colors-solarized'

" Easy way to wrap/unwrap words
Plugin 'tpope/vim-surround'

" Fuzzy search
Plugin 'ctrlpvim/ctrlp.vim'

" Better and faster grep
Plugin 'rking/ag.vim'

" Indent guides
Plugin 'nathanaelkane/vim-indent-guides'

" Syntax highlight
Plugin 'sheerun/vim-polyglot'

" Syntax highlight for ES2015
Plugin 'othree/yajs.vim'

" Syntaxt highlighting for CSSNext
Plugin 'hail2u/vim-css3-syntax'

" Code snippets
Plugin 'sirver/ultisnips'

" Real time color preview for CSS
Plugin 'ap/vim-css-color'

" Code comments helper
Plugin 'tpope/vim-commentary'

" Git wrapper
Plugin 'tpope/vim-fugitive'

" Unix commands wrapper
Plugin 'tpope/vim-eunuch'

" Buffer navigation improved
Plugin 'tpope/vim-unimpaired'

" Easy string coercion
Plugin 'tpope/vim-abolish'

" Programming metrics
Plugin 'wakatime/vim-wakatime'

" Automatically create folders when writing buffers to disk
Plugin 'pbrisbin/vim-mkdir'

" Smarter increment/decrement numbers for Vim
Plugin 'tpope/vim-speeddating'

" Show Git diff indicators on the sidebar
Plugin 'airblade/vim-gitgutter'

" Useful status bar
Plugin 'itchyny/lightline.vim'

" So we can repeat plugin commands
Plugin 'tpope/vim-repeat'

"###############################################################################
"# General settings
"###############################################################################

" Close Vundle
call vundle#end()

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

" Remove automatic text wrapping
set nowrap

" Display status bar
set laststatus=2

" Backups are annoying, let file versioning handles this
set nobackup
set nowritebackup

" Stop being bothered by Vim swap files
set noswapfile

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

" Remap the space key to toggle current fold
nnoremap <tab> za

" Fix folding on JSON and CSS files
autocmd Filetype json,css,scss setlocal foldmethod=syntax

" Limits the body of Git commit messages to 72 characters
autocmd Filetype gitcommit setlocal spell textwidth=72

" Enable spell checking on certain file types
autocmd BufRead,BufNewFile *.md,gitcommit setlocal spell complete+=kspell

" Auto save files when focus is lost
au FocusLost * silent! wa

"###############################################################################
"# Theming
"###############################################################################

" Define color scheme
colorscheme solarized

" Enable italic text
highlight Comment cterm=italic

" Display current line number in bold text
highlight CursorLineNr cterm=bold

" Set hidden characters colors to light gray
highlight NonText ctermfg=187 ctermbg=white
highlight SpecialKey ctermfg=187 ctermbg=white

"###############################################################################
"# Emmet
"###############################################################################

" Disable Emmet for all file types
let g:user_emmet_install_global = 0

" Specifies file types for Emmet
autocmd FileType html,erb,css,scss EmmetInstall

"###############################################################################
"# CtrlP
"###############################################################################

" Use Git's `ls-files` and properly ignore hidden files
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Remap most used CtrlP commands
nnoremap <leader>f :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>

"###############################################################################
"# Indent guides
"###############################################################################

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" Disable automatic colors and specify custom ones
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=gray
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=lightgray

"###############################################################################
"# Polyglot
"###############################################################################

" Disable JavaScript on Polyglot due to conflicts with yajs
let g:polyglot_disabled = ['javascript']

"###############################################################################
"# UltiSnips
"###############################################################################

let g:UltiSnipsEditSplit='vertical'

"###############################################################################
"# Lightline
"###############################################################################

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'readonly': 'LightLineReadonly',
      \   'modified': 'LightLineModified',
      \   'filename': 'LightLineFilename'
      \ }
      \ }

function! LightLineModified()
  if &filetype == 'help'
    return ''
  elseif &modified
    return '*'
  elseif &modifiable
    return ''
  else
    return ''
  endif
endfunction

function! LightLineReadonly()
  if &filetype == 'help'
    return ''
  elseif &readonly
    return '⭤'
  else
    return ''
  endif
endfunction

function! LightLineFugitive()
  if exists('*fugitive#head')
    let _ = fugitive#head()
    return strlen(_) ? '⭠ '._ : ''
  endif
  return ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LightLineModified() ? '' . LightLineModified() : ' ')
endfunction

"###############################################################################
"# HyperTerm
"###############################################################################

if $TERM_PROGRAM == 'hyperterm'
  autocmd BufRead,BufNewFile *.* setlocal nospell complete=
  colorscheme default
  hi CursorLineNr ctermfg=none cterm=bold
  hi LineNr ctermfg=none
  hi NonText ctermfg=darkgray
  hi SpecialKey ctermfg=darkgray
  hi Comment cterm=none ctermfg=darkgray
  hi Constant cterm=bold ctermfg=white
  hi Identifier cterm=bold ctermfg=white
  hi Function cterm=bold ctermfg=white
  hi Statement cterm=bold ctermfg=white
  hi PreProc cterm=bold ctermfg=white
  hi Type cterm=bold ctermfg=white
  hi Special cterm=bold ctermfg=white
  hi Delimiter cterm=bold ctermfg=white
  hi Search cterm=bold ctermfg=white ctermbg=magenta
  hi Visual cterm=none ctermfg=white ctermbg=magenta
  set colorcolumn=
  set nocursorline
endif
