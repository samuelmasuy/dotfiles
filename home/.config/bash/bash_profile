####!/usr/bin/env bash
# HISTORY
# ctl-R allows to search backward for any previous command tip:put comments with reminder words to be able to easely find it
# history | grep;  Ctrl+R;  !23; !-3; !-3:1; # Get history.
export EDITOR='nvim'
export HISTFILESIZE=10000
export HISTSIZE=10000
shopt -s histappend
export PROMPT_COMMAND='history -a'
# FUN
alias talkla='say -v Cellos "oh This is a silly song silly song silly song this is the silliest song ive ever ever heard So why keep you listening listening listening while you suppose to study to study to study its because i hate my school hate my school hate my school its because i hate my school more than anything else No its because youve no life youve no life youve no life and you better go get one after forwarding this crap"'

alias pyhton='python' # Correct mistyping.
alias ipyhton='ipython' # Correct mistyping.
alias cafe='caffeinate -t 3600 &' # Prevent sleep for one hour.
alias clock='while sleep 1;do tput sc;tput cup 0 $(($(tput cols)-29));date;tput rc;done &' #diplay a clock
# Java.
alias javac='javac -d . '

alias du='du -kh'
# alias lk='ls -lSr'
# alias ll='ls -'
alias la='ls -lA'
alias ls='ls -G'
alias lt="ls | say -vz"
# Better prompt, case-insensitive search by default.
export LESS="-i-P%f (%i/%m) Line %lt/%L"

# Return to the previous working directory.
alias cdp="cd ~-" # Alter. cd $OLDPWD
alias ~='cd ~' # Return to home
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
# Open in finder
alias f='open -a Finder ./'
# Clear terminal
alias c='clear'
alias cic='set completion-ignore-case On'

set -o vi

function my_ip {
    ifconfig | grep 'broadcast' | awk '{print $6}'
}
function latest {
  ls -t $1/* | head -n 1
}
trash() {
    mv "${1}" ~/.Trash;
}
sbl() { sublime "${1}"; }

sman() { man "${1}" | col -b | sublime; }

cd() { builtin cd "$@"; ls; }

mcd () { mkdir -p "$1" && cd "$1"; }

# ditto -ck --sequesterRsrc file file.zip # Compressing a Single File.
# ditto -ck --sequesterRsrc --keepParent folder/ folder.zip # Compressing a Folder.
extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}
export PS1="\[\033[01;33m\]\$(date +%H:%M:%S) \[\e[0;35m\]\u\[\e[0;37m\]@\[\e[0;32m\]$(scutil --get ComputerName): \[\e[0;36m\]\w\$(__git_ps1 \" (%s) \")\n\[\e[0m\]\$ "

# Don't let virtualenv show prompts by itself.
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/lib:$PATH
export PATH=/usr/local/include:$PATH
export PATH=/usr/local/share/python:$PATH

export PATH="/usr/local/sbin:/usr/local/bin/python:/usr/local/bin/python-config:/usr/local/bin:$HOME/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
export MANPATH="/usr/local/man:$MANPATH"
