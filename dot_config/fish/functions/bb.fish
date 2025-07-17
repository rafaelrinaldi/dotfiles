function bb --wraps='brew update; brew upgrade' --description 'alias bb=brew update; brew upgrade'
    brew update
    brew upgrade
    brew cleanup $argv

    # Homebrew will automatically install Node.js because other tools
    # depend on it.
    # We don't want this since `asdf` is the Node.js version manager, so we force
    # a uninstall here just in case it happens.
    # Annoying but works for now.
    brew uninstall node --ignore-dependencies

end
