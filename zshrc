# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of zsh theme to load.
# ZSH_THEME="my_theme"
ZSH_THEME=powerlevel10k/powerlevel10k

# Plugins for zsh.
plugins=(git mvn docker zsh_reload z fast-syntax-highlighting history-substring-search)
# kubectl go osx tmux

# Initiate oh-my-zsh.
source $ZSH/oh-my-zsh.sh

source $HOME/.zsh/exports.zsh
source $HOME/.zsh/aliases.zsh
source $HOME/.zsh/functions.zsh
[[ -f $HOME/.zsh/secrets.zsh ]] && source $HOME/.zsh/secrets.zsh
[[ -f $HOME/.zsh/work.zsh ]] && source $HOME/.zsh/work.zsh

bindkey -v
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=white'

zstyle ':completion:*:cd:*' ignore-parents parent pwd # cd will never select the parent directory

# source /usr/local/bin/virtualenvwrapper.sh

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

complete -o nospace -C /usr/local/bin/vault vault

[[ -f $HOME/.zsh/fzf.zsh ]] && source $HOME/.zsh/fzf.zsh

# To customize prompt, run `p10k configure`
[[ ! -f $HOME/.zsh/p10k.zsh ]] || source $HOME/.zsh/p10k.zsh
