export PATH="$HOME/bin:/usr/local/bin:/usr/local/heroku/bin:/usr/local/bin/python:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
export MANPATH="/usr/local/man:$MANPATH"

export TERM=xterm-256color
# Path to oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Location of history file.
export HISTFILE=~/.histfile
# Number of lines kept in history.
export HISTSIZE=10000
# Number of lines saved in the history after logout.
export SAVEHIST=10000
export PROMPT_COMMAND='history -a'
# virtualenvs.
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
VIRTUAL_ENV_DISABLE_PROMPT=1
# pip cache.
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache
