function ll --description "Run eza and ensure theme matches active OS appearance settings"
    # if dark
    #     ln -sf $EZA_CONFIG_DIR/themes/rose-pine.yml $EZA_CONFIG_DIR/theme.yml
    # else
    #     ln -sf $EZA_CONFIG_DIR/themes/rose-pine-dawn.yml $EZA_CONFIG_DIR/theme.yml
    # end

    eza --oneline --icons=always --git --level=2
end
