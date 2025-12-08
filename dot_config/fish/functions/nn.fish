function nn --description "nuke 'node_modules' directories recursively"
    if not test -e package.json
        echo "No package.json found in the current directory"
        return 1
    end

    set -l cwd (echo "$PWD" | sed "s|$HOME|~|")

    if gum confirm "Nuke all 'node_modules' in $cwd?"
        gum spin --spinner dot --title "Deleting..." -- \
            fd node_modules . --type directory --no-ignore --exec rm -rf {}
        echo "Done."
    else
        echo "Aborted."
    end
end
