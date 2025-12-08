function bb --wraps='brew update; brew upgrade' --description 'brew update & upgrade'
    gum spin --spinner dot --title "Updating Homebrew..." -- \
        brew update
    brew upgrade
    brew cleanup $argv
    echo "Done."
end
