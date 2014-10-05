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
# Higlight the matching pattern in a file.
function highlight () {
    grep --color -E "$1|$" "$@"
}
# Utilities to update, upgrade, clean and doctor homebrew.
function brewery() {
    brew bundle ~/Dropbox/Github/dotfiles/brewery
}
