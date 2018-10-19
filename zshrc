# Path to oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of zsh theme to load.
ZSH_THEME=""

# Plugins for zsh.
plugins=(git tmux mvn tmuxinator docker brew osx kubectl colorize go vi-mode web-search zsh_reload z vagrant zsh-syntax-highlighting history-substring-search)

source ~/.zsh/colors.zsh
source ~/.zsh/exports.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/secrets.zsh

# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down

# Initiate oh-my-zsh.
source $ZSH/oh-my-zsh.sh

autoload -U promptinit; promptinit
PURE_CMD_MAX_EXEC_TIME=10
prompt pure

zstyle ':completion:*:cd:*' ignore-parents parent pwd # cd will never select the parent directory
# ternjs settings to load file eagerly
ulimit -n 2048

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/smasuy/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/smasuy/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/smasuy/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/smasuy/google-cloud-sdk/completion.zsh.inc'; fi

[[ -s "$HOME/.tug/scripts/tug" ]] && source "$HOME/.tug/scripts/tug"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$PATH:/usr/local/opt/node@8/bin"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /Users/smasuy/bin/vault vault

# source /usr/local/bin/virtualenvwrapper.sh
