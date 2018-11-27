
source ~/.zsh/exports.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/secrets.zsh

export ZPLUG_HOME=$DOTFILES_HOME/zsh/zplug

source $ZPLUG_HOME/init.zsh

# zplug "zsh-users/zsh-autosuggestions", from:github
zplug "zsh-users/zsh-completions", from:github, defer:0
zplug "zsh-users/zsh-syntax-highlighting", from:github, defer:2
zplug "zsh-users/zsh-history-substring-search", from:github, defer:2

zplug "plugins/git", from:oh-my-zsh
zplug "plugins/tmux", from:oh-my-zsh
zplug "plugins/tmuxinator", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/osx", from:oh-my-zsh
zplug "plugins/kubectl", from:oh-my-zsh
zplug "plugins/go", from:oh-my-zsh
zplug "plugins/zsh_reload", from:oh-my-zsh
zplug "plugins/z", from:oh-my-zsh

export ZSH_PLUGINS_ALIAS_TIPS_TEXT='💡 '

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=white'

export ZSH=$ZPLUG_HOME/repos/robbyrussell/oh-my-zsh
ZSH_THEME=""
plugins=()
source $ZSH/oh-my-zsh.sh

autoload -U promptinit; promptinit
PURE_CMD_MAX_EXEC_TIME=10
prompt pure

bindkey -v
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down

zstyle ':completion:*:cd:*' ignore-parents parent pwd # cd will never select the parent directory

[[ -s "$HOME/.tug/scripts/tug" ]] && source "$HOME/.tug/scripts/tug"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /Users/smasuy/bin/vault vault

# source /usr/local/bin/virtualenvwrapper.sh
