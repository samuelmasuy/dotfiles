# Path to oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of zsh theme to load.
ZSH_THEME=""

# Plugins for zsh.
plugins=(git tmux mvn tmuxinator docker osx kubectl go web-search zsh_reload z zsh-syntax-highlighting history-substring-search)

source ~/.zsh/exports.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/secrets.zsh

# Initiate oh-my-zsh.
source $ZSH/oh-my-zsh.sh

autoload -U promptinit; promptinit
PURE_CMD_MAX_EXEC_TIME=10
prompt pure

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=white'

bindkey -v
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down

zstyle ':completion:*:cd:*' ignore-parents parent pwd # cd will never select the parent directory

[[ -s "$HOME/.tug/scripts/tug" ]] && source "$HOME/.tug/scripts/tug"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /Users/smasuy/bin/vault vault

# source /usr/local/bin/virtualenvwrapper.sh
