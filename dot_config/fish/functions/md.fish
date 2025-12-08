function md --description "get a GitHub flavored markdown compliant banner"
    argparse 'v/variant=' -- $argv
    set -l variants note tip important warning caution

    set -l variant

    if set -q _flag_variant
        if not contains -- $_flag_variant $variants
            gum style --foreground 1 \
                "Invalid variant '$_flag_variant'. Must be one of: $variants"
            return 1
        end
        set variant $_flag_variant
    else
        set variant (gum choose $variants)
    end

    set -l message (gum write --placeholder "Write your $variant text")
    if test -z "$message"
        gum style --foreground 3 "No message provided."
        return 1
    end

    # Output using echo which handles newlines properly
    echo "> [!"(string upper $variant)"]"
    echo $message | sed 's/^/> /'
end
