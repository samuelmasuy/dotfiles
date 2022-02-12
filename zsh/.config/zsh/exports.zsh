# Location of history file.
export HISTFILE="$XDG_DATA_HOME"/zsh/history
# Number of lines kept in history.
export HISTSIZE=50000
# Number of lines saved in the history after logout.
export SAVEHIST=10000
export EDITOR=nvim
export VISUAL=nvim

export ZSH_CACHE_DIR="${XDG_CACHE_HOME}/zsh"

export GOPATH=$HOME
export DOTFILES_HOME=$HOME/.dotfiles
export IDEA_HOME="/Applications/IntelliJ IDEA CE.app/Contents"
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export _ZO_DATA_DIR="$XDG_DATA_HOME/zoxide"
export GEM_HOME="$XDG_DATA_HOME"/gem
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem
export HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME"/httpie
export PYLINTHOME="$XDG_CACHE_HOME"/pylint
export AZURE_CONFIG_DIR=$XDG_DATA_HOME/azure
export _RESURRECT_DIR=$XDG_DATA_HOME/tmux/resurrect
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export SHPOTIFY_CONFIG_FILE="$XDG_CONFIG_HOME"/shpotify/config
export ASDF_CONFIG_FILE="$XDG_CONFIG_HOME"/asdf/config
export ASDF_DATA_DIR="$XDG_DATA_HOME"/asdf
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/ripgreprc"

export PATH="$PATH:$HOME/bin/:$HOME/bin/aws/:$HOME/bin/git-toolbelt/"
export PATH="$PATH:/usr/local/sbin:/Applications/VirtualBox.app/Contents/MacOS"
export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$PATH:$JAVA_HOME/bin"
export PATH="$PATH:$XDG_DATA_HOME/yarn/bin"
export PATH="$PATH:$XDG_DATA_HOME/npm/bin"
export PATH="$PATH:$HOME/src/github.com/jive/jh/helper"
export PATH="$PATH:$HOME/src/github.com/jive/jh"
export PATH="$PATH:/usr/local/opt/curl-openssl/bin"
export PATH="$PATH:/usr/local/opt/curl-openssl/bin"
export PATH="$PATH:$CARGO_HOME/bin"
export PATH="$PATH:${HOME}/.krew/bin"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
# export PATH="$PATH:/usr/local/opt/node@14/bin"

export MANPATH="/usr/local/man:$MANPATH"

export MAVEN_OPTS="-Xmx1024m -Xms512m"

# Colors handling.
autoload colors; colors;

export NODE_PATH='/usr/local/lib/node_modules'
# export LDFLAGS="-L/usr/local/opt/node@14/lib"
# export CPPFLAGS="-I/usr/local/opt/node@14/include"

export PROMPT_COMMAND='history -a'
# ignore storing commands prefixed by a space
setopt hist_ignore_space

export LESSHISTFILE=-

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
