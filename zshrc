# Set name of zsh theme to load.
ZSH_THEME="my_theme"

source ~/.zsh/colors.zsh
source ~/.zsh/exports.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/functions.zsh
# Initiate z command.
. $ZSH/custom/plugins/z/z.sh
# Plugins for zsh.
plugins=(git tmux tmuxinator brew github osx sublime virtualenvwrapper colorize gradle pip vi-mode web-search zsh_reload z vagrant zsh-syntax-highlighting history-substring-search alias-tips)

alias emacs="/usr/local/Cellar/emacs/24.x/Emacs.app/Contents/MacOS/Emacs -nw"
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Initiate oh-my-zsh.
source $ZSH/oh-my-zsh.sh

export NVM_DIR="/Users/samuel/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
nvm use stable
