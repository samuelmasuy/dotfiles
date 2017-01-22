export GOPATH=$HOME/go
export MAVEN_OPTS="-Xmx1024m -Xms512m"
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
#export IDEA_JDK="/Library/Java/JavaVirtualMachines/jdk1.8.0_72.jdk/Contents/Home

export PATH="$PATH:/usr/local/sbin:/usr/local/bin/python:/Applications/VirtualBox.app/Contents/MacOS"
export PATH="$PATH:/usr/local/bin:$HOME/bin:/usr/bin:/bin:/usr/sbin:/sbin:$GOPATH/bin"
export PATH="$PATH:$JAVA_HOME/bin:/opt/apache-maven-3.3.9/bin"
export PATH="$PATH:$HOME/.yarn/bin"
export MANPATH="/usr/local/man:$MANPATH"

export EDITOR="nvim"

export NODE_PATH='/usr/local/lib/node_modules'

# Location of history file.
export HISTFILE=~/.histfile
# Number of lines kept in history.
export HISTSIZE=10000
# Number of lines saved in the history after logout.
export SAVEHIST=10000
export PROMPT_COMMAND='history -a'
# virtualenvs.
#export WORKON_HOME=$HOME/.virtualenvs
#source /usr/local/bin/virtualenvwrapper.sh
#VIRTUAL_ENV_DISABLE_PROMPT=1
# pip cache.
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache
# Tmux config.
export DISABLE_AUTO_TITLE=true
