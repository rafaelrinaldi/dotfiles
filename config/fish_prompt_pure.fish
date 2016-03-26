function parse_git_branch
  echo (command git symbolic-ref HEAD ^/dev/null)
end

function parse_git_status
  echo (command git status -b -s --ignore-submodules=dirty)
end

function fish_prompt
  set -l basedir_name (basename (prompt_pwd))

  set -l GIT_BRANCH (parse_git_branch)
  set -l GIT_STATUS (parse_git_status)

  # Symbols

  set -l PURE_PROMPT_SYMBOL "❯"
  set -l PURE_GIT_DOWN_ARROW "⇣"
  set -l PURE_GIT_UP_ARROW "⇡"
  set -l PURE_GIT_DIRTY "*"

  # Colors

  set -l color_red (set_color red)
  set -l color_green (set_color green)
  set -l color_blue (set_color blue)
  set -l color_yellow (set_color yellow)
  set -l color_gray (set_color white)
  set -l color_normal (set_color normal)

  if test -n "$GIT_BRANCH"
    echo "yup git"
  else
    echo "nope git"
  end

  #echo "$basedir_name $IS_GIT_REPOSITORY"
  #echo -n -s "$color_yellow$PURE_PROMPT_SYMBOL$color_normal "

  # Reset color
  #set_color normal
end
