function get_pwd() {
    echo "${PWD/$HOME/~}"
}
function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    # hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo '✭'
}
function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}
function git_prompt_info() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_S"
}

#PROMPT='
#$fg[magenta]$(date +%H:%M:%S) $fg[white]$(virtualenv_info)$fg[cyan]%m: $fg[yellow]$(get_pwd)  $(
#$reset_color$(prompt_char) '
PROMPT='%{magenta}$(date +%H:%M:%S)'


ZSH_THEME_GIT_PROMPT_PREFIX="[git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="]$reset_color"
ZSH_THEME_GIT_PROMPT_DIRTY="$fg[red]+"
ZSH_THEME_GIT_PROMPT_CLEAN="$fg[green]"
