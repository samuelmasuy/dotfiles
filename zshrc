# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of zsh theme to load.
ZSH_THEME="my_theme"

# Plugins for zsh.
plugins=(git tmux nvm tmuxinator brew osx sublime virtualenvwrapper colorize gradle go vi-mode web-search zsh_reload z vagrant zsh-syntax-highlighting history-substring-search)

source ~/.zsh/colors.zsh
source ~/.zsh/exports.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/functions.zsh

alias cdg="cd $HOME/Dropbox/Github/dotfiles"
alias cdb="cd $HOME/Dropbox/Bitbucket/dotfiles"

alias emacs="/usr/local/Cellar/emacs/24.x/Emacs.app/Contents/MacOS/Emacs -nw"
alias vim="nvim"
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Initiate oh-my-zsh.
source $ZSH/oh-my-zsh.sh

export NVM_DIR="/Users/samuel/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
nvm use default
