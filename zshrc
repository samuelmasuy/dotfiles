# Set name of zsh theme to load.
ZSH_THEME="my_theme"
source ~/.zsh/colors.zsh
source ~/.zsh/exports.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/functions.zsh
# Initiate z command.
. ${HOME}/.oh-my-zsh/z/z.sh
# Plugins for zsh.
plugins=(git git-flow brew github osx sublime virtualenvwrapper colorize pip vi-mode zsh_reload zsh-syntax-highlighting)

# Initiate oh-my-zsh.
source $ZSH/oh-my-zsh.sh

source /Users/samuel/.iterm2_shell_integration.zsh
