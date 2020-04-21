# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to oh-my-zsh installation.
export ZSH=${XDG_CONFIG_HOME:-$HOME/.config}/oh-my-zsh
hash -d c=$XDG_CONFIG_HOME

# Set name of zsh theme to load.
# ZSH_THEME="my_theme"
ZSH_THEME=powerlevel10k/powerlevel10k

# Plugins for zsh.
plugins=(git mvn docker zsh_reload z colored-man-pages fast-syntax-highlighting history-substring-search)
# kubectl go osx tmux

# Initiate oh-my-zsh.
source $ZSH/oh-my-zsh.sh

source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/config/exports.zsh
source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/config/aliases.zsh
source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/config/functions.zsh
[[ -f ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/config/secrets.zsh ]] && source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/config/secrets.zsh
[[ -f ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/config/work.zsh ]] && source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/config/work.zsh

bindkey -v
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=white'

zstyle ':completion:*:cd:*' ignore-parents parent pwd # cd will never select the parent directory

# source /usr/local/bin/virtualenvwrapper.sh
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform
complete -o nospace -C /usr/local/bin/vault vault

[[ -f ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/config/fzf.zsh ]] && source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/config/fzf.zsh

# To customize prompt, run `p10k configure`
[[ ! -f ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/config/p10k.zsh ]] || source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/config/p10k.zsh