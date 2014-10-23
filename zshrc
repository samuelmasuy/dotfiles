# Set name of zsh theme to load.
ZSH_THEME="my_theme"
source ~/.zsh/colors.zsh
source ~/.zsh/exports.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/functions.zsh
# Initiate z command.
. ${HOME}/.oh-my-zsh/custom/plugins/z/z.sh
# Plugins for zsh.
plugins=(git git-flow tmux tmuxinator brew github osx sublime virtualenvwrapper colorize pip vi-mode zsh_reload z vagrant zsh-syntax-highlighting)

# Initiate oh-my-zsh.
source $ZSH/oh-my-zsh.sh

#. "/usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh"


