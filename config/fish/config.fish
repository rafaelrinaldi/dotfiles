set -x LSCOLORS ExFxCxDxBxegedabagacad
set -x LC_CTYPE en_US.UTF-8
set -x EDITOR vim

# $PATH equivalent
set -U fish_user_paths /usr/local/bin (yarn global bin)

# Tweak search highlight colors
set -U fish_color_search_match --background=cyan

# Aliases
alias cask 'brew cask'
alias d 'cd $HOME/dev'
alias git hub
alias ip 'curl icanhazip.com'
alias ipl 'ipconfig getifaddr en0'
alias npm-clean 'rm -rf ./node_modules; npm cache clean; npm install'
alias rg 'rg --colors "match:bg:yellow" --colors "match:style:bold"'
alias w 'cd $HOME/work'
