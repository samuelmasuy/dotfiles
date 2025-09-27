set -x AZURE_CONFIG_DIR $XDG_DATA_HOME/azure
set -x CARGO_HOME $XDG_DATA_HOME/cargo
set -x GEM_HOME $XDG_DATA_HOME/gem
set -x GEM_SPEC_CACHE $XDG_CACHE_HOME/gem
set -x GOBIN $HOME/.local/bin
set -x GOPATH $HOME
set -x GRADLE_USER_HOME $XDG_DATA_HOME/gradle
set -x GROOVY_HOME /usr/local/opt/groovy/libexec
set -x HTTPIE_CONFIG_DIR $XDG_CONFIG_HOME/httpie
set -x IDEA_HOME "/Applications/IntelliJ IDEA CE.app/Contents"
set -x KREW_ROOT $XDG_DATA_HOME/krew
set -x MINIKUBE_HOME $XDG_CONFIG_HOME/minikube
set -x NODE_REPL_HISTORY $XDG_DATA_HOME/node_repl_history
set -x NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -x PYLINTHOME $XDG_CACHE_HOME/pylint
set -x RIPGREP_CONFIG_PATH $XDG_CONFIG_HOME/ripgrep/ripgreprc
set -x RUSTUP_HOME $XDG_DATA_HOME/rustup
set -x TEALDEER_CONFIG_DIR $XDG_CONFIG_HOME/tealdeer
set -x _RESURRECT_DIR $XDG_DATA_HOME/tmux/resurrect
set -x _ZO_DATA_DIR $XDG_DATA_HOME/zoxide

fish_add_path $CARGO_HOME/bin
fish_add_path $KREW_ROOT/bin

# set -x DOCKER_DEFAULT_PLATFORM linux/amd64

set -x MANPAGER 'nvim +Man!'

set -x NODE_PATH /usr/local/lib/node_modules

set -x LESSHISTFILE -

set -x DISABLE_AUTO_TITLE true

set -x BAT_THEME kanagawa
set -x BAT_STYLE changes

