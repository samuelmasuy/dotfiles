export GOPATH=$HOME
export MAVEN_OPTS="-Xmx1024m -Xms512m"
# export JAVA_HOME=`/usr/libexec/java_home -v 11`
export DOTFILES_HOME=$HOME/.dotfiles
export IDEA_HOME="/Applications/IntelliJ IDEA CE.app/Contents"
#export IDEA_JDK="/Library/Java/JavaVirtualMachines/jdk1.8.0_72.jdk/Contents/Home

export PATH="$PATH:$HOME/bin/"
export PATH="$PATH:/usr/local/sbin:/Applications/VirtualBox.app/Contents/MacOS"
export PATH="$PATH:/usr/local/bin:$HOME/bin/aws/:$HOME/bin/git-toolbelt/:/usr/bin:/bin:/usr/sbin:/sbin:$GOPATH/bin"
export PATH="$PATH:$JAVA_HOME/bin"
export PATH="$PATH:$HOME/.yarn/bin"
export PATH="$PATH:$HOME/src/github.com/jive/jh/helper"
export PATH="$PATH:/usr/local/opt/node@12/bin"
export PATH="$PATH:/usr/local/opt/curl-openssl/bin"
export PATH="$PATH:/usr/local/opt/python@3.8/bin"
export PATH="$PATH:/usr/local/opt/curl-openssl/bin"

export MANPATH="/usr/local/man:$MANPATH"

# Colors handling.
autoload colors; colors;

export EDITOR="nvim"

# export NODE_PATH='/usr/local/lib/node_modules'
export LDFLAGS="-L/usr/local/opt/node@12/lib"
export CPPFLAGS="-I/usr/local/opt/node@12/include"

# Location of history file.
export HISTFILE=~/.histfile
# Number of lines kept in history.
export HISTSIZE=10000
# Number of lines saved in the history after logout.
export SAVEHIST=10000
export PROMPT_COMMAND='history -a'
# ignore storing commands prefixed by a space
setopt hist_ignore_space

#export WORKON_HOME=$HOME/.virtualenvs
#source /usr/local/bin/virtualenvwrapper.sh
#VIRTUAL_ENV_DISABLE_PROMPT=1
# pip cache.
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache
# Tmux config.
export DISABLE_AUTO_TITLE=true

export GROOVY_HOME=/usr/local/opt/groovy/libexec

export BAT_THEME="OneHalfDark"
export BAT_STYLE="changes"
export ISP_TABLE="isp.jumpy.v1"
export NURSE_TABLE="nurse.instances.v2"

export GOPROXY=https://nexus.devops.jive.com/repository/go-all/
export GOPRIVATE=github.com/jive/*
