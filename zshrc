# zmodload zsh/zprof
# Path to oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of zsh theme to load.
# ZSH_THEME="my_theme"
ZSH_THEME=powerlevel10k/powerlevel10k

# Plugins for zsh.
plugins=(git mvn tmuxinator docker kubectl helm web-search zsh_reload z fast-syntax-highlighting history-substring-search)
# kubectl go osx tmux 

source $HOME/.zsh/exports.zsh
source $HOME/.zsh/aliases.zsh
source $HOME/.zsh/functions.zsh
source $HOME/.zsh/secrets.zsh

# Initiate oh-my-zsh.
source $ZSH/oh-my-zsh.sh
# source $HOME/.zsh/pure10k.zsh
source $HOME/.zsh/purepower.zsh

# function zle-line-init zle-keymap-select {
#   PROMPT=`$HOME/src/github.com/xcambar/purs/target/release/purs prompt -k "$KEYMAP" -r "$?"`
#   zle reset-prompt
# }
# zle -N zle-line-init
# zle -N zle-keymap-select

# autoload -Uz add-zsh-hook

# function _prompt_purs_precmd() {
#   $HOME/src/github.com/xcambar/purs/target/release/purs precmd --git-detailed
# }
# add-zsh-hook precmd _prompt_purs_precmd

# autoload -U promptinit; promptinit
# PURE_CMD_MAX_EXEC_TIME=10
# prompt pure

bindkey -v
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=white'

zstyle ':completion:*:cd:*' ignore-parents parent pwd # cd will never select the parent directory

[[ -s "$HOME/.tug/scripts/tug" ]] && source "$HOME/.tug/scripts/tug"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# source /usr/local/bin/virtualenvwrapper.sh

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

complete -o nospace -C /usr/local/bin/vault vault

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh