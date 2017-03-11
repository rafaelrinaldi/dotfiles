set -g PATH /usr/local/bin $PATH
set -g LSCOLORS ExFxCxDxBxegedabagacad
set -g LC_CTYPE en_US.UTF-8
set -g EDITOR vim
set -g TERM xterm-256color-italic

set fish_color_search_match --background=white

alias cask 'brew cask'
alias git hub
alias ip 'curl icanhazip.com'
alias npm-clean 'rm -rf ./node_modules; npm cache clean; npm install'
