# vim: ft=fish :
set fish_greeting

# Mostly to avoid random issues with Xcode
set -e PREFIX

# Abbreviations
abbr -a dstroy "find $PWD -name '.DS_Store' -type f -delete"
abbr -a w "cd $HOME/work"
abbr -a d "cd $HOME/dev"
abbr -a deps "yarn dlx npm-check-updates -p yarn --cwd . -i"

# Aliases
alias n=nvim
alias y=yarn
alias t=tmux
alias b=brew
alias lg=lazygit

# Git
alias g="git"
alias gb="git branch"
alias gc="git commit"
alias gca="git commit --amend"
alias gclean="git clean -fd"
alias gco="git checkout"
alias gd="git diff"
alias gf="git fetch --all --prune"
alias gignore="git update-index --assume-unchanged"
alias gl="git log --oneline --decorate --all --graph"
alias gp="git push"
alias gpl="git pull"
alias gpo="git push origin"
alias grh="git reset HEAD"
alias gs="git status"
alias gundo="git reset HEAD~1"
alias gunignore="git update-index --no-assume-unchanged"
alias gwip="git add . && git commit -m "WIP""

# Initialize asdf (needed for nodejs, java, etc.)
# Try Homebrew installation first
if test -f /opt/homebrew/opt/asdf/libexec/asdf.fish
    source /opt/homebrew/opt/asdf/libexec/asdf.fish
else if test -f (brew --prefix asdf)/libexec/asdf.fish
    source (brew --prefix asdf)/libexec/asdf.fish
else if test -f ~/.asdf/asdf.fish
    source ~/.asdf/asdf.fish
end

# Ensure asdf shims are in PATH (fallback if asdf init didn't add them)
if test -d ~/.asdf/shims
    fish_add_path ~/.asdf/shims
end

# $PATH
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path /usr/local/bin
fish_add_path $HOME/.local/bin

# Load env vars
source $HOME/.config/fish/env.fish

# Starship prompt
starship init fish | source

# Zoxide (smart cd)
zoxide init fish | source
