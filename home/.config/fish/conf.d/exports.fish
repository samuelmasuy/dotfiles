set -gx AZURE_CONFIG_DIR $XDG_DATA_HOME/azure
set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx EZA_CONFIG_DIR $XDG_CONFIG_HOME/eza
set -gx GEM_HOME $XDG_DATA_HOME/gem
set -gx GEM_SPEC_CACHE $XDG_CACHE_HOME/gem
set -gx GOBIN $HOME/.local/bin
set -gx GOPATH $HOME
set -gx GRADLE_USER_HOME $XDG_DATA_HOME/gradle
set -gx GROOVY_HOME /usr/local/opt/groovy/libexec
set -gx HTTPIE_CONFIG_DIR $XDG_CONFIG_HOME/httpie
set -gx IDEA_HOME "/Applications/IntelliJ IDEA CE.app/Contents"
set -gx KREW_ROOT $XDG_DATA_HOME/krew
set -gx MINIKUBE_HOME $XDG_CONFIG_HOME/minikube
set -gx NODE_REPL_HISTORY $XDG_DATA_HOME/node_repl_history
set -gx NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -gx PYLINTHOME $XDG_CACHE_HOME/pylint
set -gx RIPGREP_CONFIG_PATH $XDG_CONFIG_HOME/ripgrep/ripgreprc
set -gx RUSTUP_HOME $XDG_DATA_HOME/rustup
set -gx TEALDEER_CONFIG_DIR $XDG_CONFIG_HOME/tealdeer
set -gx _RESURRECT_DIR $XDG_DATA_HOME/tmux/resurrect
set -gx _ZO_DATA_DIR $XDG_DATA_HOME/zoxide

fish_add_path $CARGO_HOME/bin
fish_add_path $KREW_ROOT/bin

# set -x DOCKER_DEFAULT_PLATFORM linux/amd64

set -gx MANPAGER 'nvim +Man!'

set -gx NODE_PATH /usr/local/lib/node_modules

set -gx LESSHISTFILE -

set -gx DISABLE_AUTO_TITLE true

set -gx BAT_THEME kanagawa
set -gx BAT_STYLE changes
