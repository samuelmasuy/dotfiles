# SUPER CRUNCH - created from CRUNCH
# CRUNCH - created from Steve Eley's cat waxing.
# Initially hacked from the Dallas theme. Thanks, Dallas Reedy.

CRUNCH_BRACKET_COLOR="%{$fg[white]%}"
CRUNCH_TIME_COLOR="%{$fg[magenta]%}"
CRUNCH_DIR_COLOR="%{$fg[cyan]%}"
CRUNCH_CHAR_COLOR="%{$fg[green]%}"
CRUNCH_CHAR_YELLOW_COLOR="%{$fg[yellow]%}"
CRUNCH_CHAR_RED_COLOR="%{$fg[red]%}"
CRUNCH_GIT_BRANCH_COLOR="%{$fg[green]%}"
CRUNCH_GIT_CLEAN_COLOR="%{$fg[green]%}"
CRUNCH_GIT_DIRTY_COLOR="%{$fg[red]%}"
CRUNCH_HOST="%{$fg[blue]%}"


# These Git variables are used by the oh-my-zsh git_prompt_info helper:
ZSH_THEME_GIT_PROMPT_PREFIX="$CRUNCH_BRACKET_COLOR:$CRUNCH_GIT_BRANCH_COLOR"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_CLEAN=" $CRUNCH_GIT_CLEAN_COLOR✓"
ZSH_THEME_GIT_PROMPT_DIRTY=" $CRUNCH_GIT_DIRTY_COLOR✗"

function _prompt_char() {
    echo '$CRUNCH_CHAR_YELLOW_COLOR❯$CRUNCH_CHAR_RED_COLOR❯$CRUNCH_CHAR_COLOR❯%f'
}

# Our elements:
CRUNCH_TIME_="$CRUNCH_BRACKET_COLOR{$CRUNCH_TIME_COLOR%T$CRUNCH_BRACKET_COLOR}%{$reset_color%}"
CRUNCH_USER="$CRUNCH_DIR_COLOR%n$CRUNCH_BRACKET_COLOR at $CRUNCH_HOST%m:"
CRUNCH_DIR_="$CRUNCH_DIR_COLOR%~\$(git_prompt_info) "

local ret_status="%(?:$CRUNCH_GIT_CLEAN_COLOR:$CRUNCH_GIT_DIRTY_COLOR)❯"

# Put it all together!
PROMPT="$CRUNCH_TIME_ $CRUNCH_USER $CRUNCH_DIR_
${ret_status}%{$reset_color%} "



# OLD
# function get_pwd() {
#    echo "${PWD/$HOME/~}"
#}
#function prompt_char {
#    git branch >/dev/null 2>/dev/null && echo '%F{green}±%f' && return
#    hg root >/dev/null 2>/dev/null && echo '%F{green}☿%f' && return
#    echo '%F{red}❯%F{yellow}❯%F{green}❯%f'
#}
#function virtualenv_info {
#    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
#}
#function git_prompt_info() {
#    ref=$(git symbolic-ref HEAD 2> /dev/null)
#    if [[ -n $ref ]]; then
#        echo "$(parse_git_dirty)${ref#refs/heads/}$(parse_git_dirty)"
#    fi
#}

#PROMPT='%{%F{magenta}%}$(date +%H:%M:%S) %{%F{white}%}$(virtualenv_info)%{%F{cyan}%}%n%{%F{white}%} at %{%F{blue}%}%m: %{%F{yellow}%}$(get_pwd) %{%f%}$(git_prompt_info)
#$(prompt_char) '

#ZSH_THEME_GIT_PROMPT_DIRTY="%{%F{red}%}%} ☹  "
#ZSH_THEME_GIT_PROMPT_CLEAN="%{%F{green}%}%} ☺  "
