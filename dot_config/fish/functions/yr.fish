function yr --description "yarn run script (with workspace support via '-w')"
    argparse w/workspace -- $argv
    or return

    test -e package.json
    or begin
        gum style --foreground 1 \
            "No package.json found in the current directory"
        return 1
    end

    if set -q _flag_workspace
        set -l workspace_data (yarn workspaces list --json 2>/dev/null)
        set -l workspaces (echo $workspace_data | jq -r '.name | select(. != null)')

        test -n "$workspaces"
        or begin
            gum style --foreground 1 \
                "No workspaces found or yarn workspaces not configured"
            return 1
        end

        set -l selected_workspace (printf '%s\n' $workspaces | gum filter \
            --height=12 \
            --placeholder="Search workspaces..." \
            --header="Pick a workspace")

        test -n "$selected_workspace"
        or begin
            gum style --foreground 3 "No workspace selected."
            return 1
        end

        set -l workspace_location (echo $workspace_data | jq -r "select(.name == \"$selected_workspace\") | .location")

        test -n "$workspace_location" -a -f "$workspace_location/package.json"
        or begin
            gum style --foreground 1 \
                "Workspace package.json not found for $selected_workspace"
            return 1
        end

        set -l workspace_scripts (jq -r '.scripts | keys[]?' "$workspace_location/package.json" 2>/dev/null)

        test -n "$workspace_scripts"
        or begin
            gum style --foreground 1 \
                "No scripts available in workspace $selected_workspace"
            return 1
        end

        set -l selected_script (printf '%s\n' $workspace_scripts | gum filter \
            --height=12 \
            --placeholder="Search scripts..." \
            --header="Pick a script to run in $selected_workspace")

        test -n "$selected_script"
        or begin
            gum style --foreground 3 "No script selected."
            return 1
        end

        set -l cmd "yarn workspace $selected_workspace run $selected_script"
        echo "Running script '$selected_script' in workspace '$selected_workspace'"
        history append $cmd
        eval $cmd
        and gum style --foreground 2 "Successfully ran script '$selected_script'"
        or gum style --foreground 1 "Failed to run script '$selected_script'"
    else
        set -l scripts (jq -r '.scripts | keys[]?' package.json 2>/dev/null)

        test -n "$scripts"
        or begin
            gum style --foreground 1 \
                "No scripts available"
            return 1
        end

        set -l selected (printf '%s\n' $scripts | gum filter \
            --height=12 \
            --placeholder="Search scripts..." \
            --header="Pick a script to run")

        test -n "$selected"
        or begin
            gum style --foreground 3 "No script selected."
            return 1
        end

        set -l cmd "yarn run $selected"
        echo "Running script: '$selected'"
        history append $cmd
        eval $cmd
        and gum style --foreground 2 "Successfully ran script '$selected'"
        or gum style --foreground 1 "Failed to run script '$selected'"
    end
end
