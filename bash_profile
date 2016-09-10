####!/usr/bin/env bash
# HISTORY
# ctl-R allows to search backward for any previous command tip:put comments with reminder words to be able to easely find it
# history | grep;  Ctrl+R;  !23; !-3; !-3:1; # Get history.
export EDITOR='vim'
export HISTFILESIZE=10000
export HISTSIZE=10000
shopt -s histappend
export PROMPT_COMMAND='history -a'
# FUN
alias talkla='say -v Cellos "oh This is a silly song silly song silly song this is the silliest song ive ever ever heard So why keep you listening listening listening while you suppose to study to study to study its because i hate my school hate my school hate my school its because i hate my school more than anything else No its because youve no life youve no life youve no life and you better go get one after forwarding this crap"'

# sudo shutdown -h +45s # Delay shutdown.
# curl -O http://www.domain.com/path/to/download.tar.gz # Download a file.
# cal 12 2013 # Display a calendar on the terminal.

# Personnal
# 'sips -Z 100x100 image.jpg#' # Resize image.
# echo "$USER@$HOSTNAME" # Display user and host.
alias pyhton='python' # Correct mistyping.
alias ipyhton='ipython' # Correct mistyping.
alias cafe='caffeinate -t 3600 &' # Prevent sleep for one hour.
alias clock='while sleep 1;do tput sc;tput cup 0 $(($(tput cols)-29));date;tput rc;done &' #diplay a clock
# Java.
alias javac='javac -d . '
# javac -Xlint
# Get serialversionUID. # java Exception... serialver Foo

# Git.
# git rm -r --cached .
# Git bash completion.
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi
# source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh

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
# export PS1="\e[0;34m\]\u\[\e[m\]@\[\e[0;32m\]\h\[\e[m\] \[\e[0;36m\]\W\[\e[m\]$ "
# export PS1="\[\033[01;35m\][\$(date +%H:%M:%S)] \[\e[0;35m\]\u\[\e[0;37m\]@\[\e[0;32m\]$(scutil --get ComputerName) \[\e[0;36m\]\W\[\e[0m\]\$ "
export PS1="\[\033[01;33m\]\$(date +%H:%M:%S) \[\e[0;35m\]\u\[\e[0;37m\]@\[\e[0;32m\]$(scutil --get ComputerName): \[\e[0;36m\]\w\$(__git_ps1 \" (%s) \")\n\[\e[0m\]\$ "
# export PS1="\h:\W \u\$(__git_ps1 \" (%s) \")\$"

# export PS1="\[\033[01;30m\][\$(date +%m%d_%H%M%S)] \u@\h\[\033[00m\]:\[\033[01;34m\]\w\n\[\033[00m\]\$ "

# Don't let virtualenv show prompts by itself.
VIRTUAL_ENV_DISABLE_PROMPT=1
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/share/python:$PATH
export WORKON_HOME=~/Envs
source /usr/local/bin/virtualenvwrapper.sh
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache
# source /usr/local/git/contrib/completion/git-completion.bash
# source /usr/local/git/contrib/completion/git-prompt.sh
### Added by the Heroku Toolbelt.
export PATH="/usr/local/heroku/bin:$PATH"

export PATH="/usr/local/sbin:/usr/local/bin/python:/usr/local/bin/python-config:/Applications/VirtualBox.app/Contents/MacOS:/usr/local/bin:/Applications/SWI-Prolog.app/Contents/MacOS:$HOME/bin:/usr/local/heroku/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/gradle/gradle-2.4/bin::/usr/local/apache-maven/apache-maven-3.3.3/bin:$PATH"
export MANPATH="/usr/local/man:$MANPATH"

export MAVEN_OPTS="-Xms256m -Xmx512m"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.7.0_79.jdk/Contents/Home"
export IDEA_JDK="/Library/Java/JavaVirtualMachines/jdk1.7.0_79.jdk/Contents/Home"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
