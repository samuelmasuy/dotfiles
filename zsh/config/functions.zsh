# Always add file or directory to the opened window in sublime.
function sublime() {
    subl -a $1
}
# Change cd to do a ls right after executing.
function chpwd() {
    emulate -L zsh
    ls
}
# Display ip adress.
function my_ip() {
    ifconfig | grep 'broadcast' | awk '{print $6}'
}
# Display latest files commited.
function latest() {
    ls -t $1/* | head -n 1
}
# Display neatly formatted path of the system.
function path() {
    echo $PATH | tr ":" "\n" | \
        awk "{ sub(\"/usr\",   \"$fg_no_bold[green]/usr$reset_color\"); \
               sub(\"/bin\",   \"$fg_no_bold[blue]/bin$reset_color\"); \
               sub(\"/opt\",   \"$fg_no_bold[cyan]/opt$reset_color\"); \
               sub(\"/sbin\",  \"$fg_no_bold[magenta]/sbin$reset_color\"); \
               sub(\"/local\", \"$fg_no_bold[yellow]/local$reset_color\"); \
               print }"
}
# Shell function to define words
# http://vikros.tumblr.com/post/23750050330/cute-little-function-time
function givedef() {
    if [[ $# -ge 2 ]] then
        echo "givedef: too many arguments" >&2
        return 1
    else
        curl "dict://dict.org/d:$1"
    fi
}
# Create a folder and cd into it.
function mcd() {
    mkdir -p "$1" && cd "$1";
}
# Copy files cd into the directory where the files where copied.
function cpd() {
    cp -- "$1" "$2" || return
    if [[ -d "$2" ]]; then
        cd -- "$2"
    else
        case $2 in
              ?*/*) cd -- "${2%/*}" ;;
              /*) cd / ;;
        esac
    fi
}
# Move files cd into the directory where the files where moved.
function mvd() {
    mv -- "$1" "$2" || return
    if [[ -d "$2" ]]; then
        cd -- "$2"
    else
        case $2 in
              ?*/*) cd -- "${2%/*}" ;;
              /*) cd / ;;
        esac
    fi
}
# Higlight the matching pattern in a file.
function highlight () {
    grep --color -E "$1|$" "$@"
}

# Search chrome history with fzf.
function chist() {
  local cols sep
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  cp -f ~/Library/Application\ Support/Google/Chrome/Default/History /tmp/h

  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi --no-hscroll --tiebreak=begin |
  sed 's#.*\(https*://\)#\1#' | xargs open
}
function fzf_killps() {
    zle -I;
    ps -ef | sed 1d | fzf -m | awk '{print $2}' | xargs kill -${1:-9} ;
};
zle -N fzf_killps;
bindkey '^Q' fzf_killps

fzf_cd() {
    zle -I;
    DIR=$(find ${1:-*} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf) && cd "$DIR" ;
};
zle -N fzf_cd;
bindkey '^E' fzf_cd
