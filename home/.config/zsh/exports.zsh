export GOPATH=$HOME
export GOBIN="$HOME/.local/bin"
export IDEA_HOME="/Applications/IntelliJ IDEA CE.app/Contents"
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export MINIKUBE_HOME="$XDG_CONFIG_HOME"/minikube
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
export ASDF_PLUGINS="$XDG_CONFIG_HOME"/asdf/.asdf-plugins
export ASDF_DATA_DIR="$XDG_DATA_HOME"/asdf
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/ripgreprc"
export KREW_ROOT="$XDG_DATA_HOME"/krew
export TEALDEER_CONFIG_DIR=$XDG_CONFIG_HOME/tealdeer

export PATH="$PATH:$HOME/.local/bin/:$HOME/.local/bin/aws/:$HOME/.local/bin/git-toolbelt/"
export PATH="$PATH:/usr/local/sbin:/Applications/VirtualBox.app/Contents/MacOS"
export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$PATH:$JAVA_HOME/bin"
export PATH="$PATH:$XDG_DATA_HOME/yarn/bin"
export PATH="$PATH:$XDG_DATA_HOME/npm/bin"
export PATH="$PATH:$CARGO_HOME/bin"
export PATH="${KREW_ROOT}/bin:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH="/opt/homebrew/opt/gnu-getopt/bin:$PATH"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

export DOCKER_DEFAULT_PLATFORM=linux/amd64

export MANPAGER='nvim +Man!'
export MANPATH="/usr/local/man:$MANPATH"

export MAVEN_OPTS="-Xmx1024m -Xms512m"

# Colors handling.
autoload colors; colors;

export NODE_PATH='/usr/local/lib/node_modules'

export PROMPT_COMMAND='history -a'
# ignore storing commands prefixed by a space
setopt hist_ignore_space

export LESSHISTFILE=-

# Tmux config.
export DISABLE_AUTO_TITLE=true

export GROOVY_HOME=/usr/local/opt/groovy/libexec

export BAT_THEME="kanagawa"
export BAT_STYLE="changes"

if [[ $(uname -m) == 'arm64' ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
