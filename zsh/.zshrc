# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to oh-my-zsh installation.
export ZSH=${XDG_CONFIG_HOME:-$HOME/.config}/oh-my-zsh
hash -d c=$XDG_CONFIG_HOME
hash -d d=$XDG_DATA_HOME

# Set name of zsh theme to load.
# ZSH_THEME="my_theme"
ZSH_THEME=powerlevel10k/powerlevel10k

# Plugins for zsh.
plugins=(git kubectl mvn docker zsh_reload z colored-man-pages fast-syntax-highlighting history-substring-search)
# go osx tmux

# Initiate oh-my-zsh.
source $ZSH/oh-my-zsh.sh

source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/config/exports.zsh
source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/config/aliases.zsh
source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/config/functions.zsh
[[ -f ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/config/secrets.zsh ]] && source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/config/secrets.zsh
[[ -f ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/config/work.zsh ]] && source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/config/work.zsh


source <(kubectl completion zsh)
# Use the Vi-like keybindings
bindkey -v
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=white'

setopt share_history          # Share History Between All Sessions.
setopt hist_expire_dups_first # Expire A Duplicate Event First When Trimming History.
setopt hist_ignore_space      # Do Not Record An Event Starting With A Space.
# setopt auto_cd                # Automatically Change Directory If A Directory Is Entered.

zstyle ':completion:*:cd:*' ignore-parents parent pwd # cd will never select the parent directory
# zstyle ':completion:*' menu select
# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# source /usr/local/bin/virtualenvwrapper.sh
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform
complete -o nospace -C $HOME/bin/vault vault

[[ -f ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/config/fzf.zsh ]] && source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/config/fzf.zsh

# To customize prompt, run `p10k configure`
[[ ! -f ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/config/p10k.zsh ]] || source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/config/p10k.zsh
