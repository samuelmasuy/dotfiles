# cd in the previous directory.
alias cdp="cd ~-"
# Display all files and directories including the hidden ones, with precision.
alias la='ls -larth'
alias ls='ls -G'
# Make the terminal say all the files and directories.
alias lt="ls | say -va"
# Open the given directory in finder.
alias f='open .'
# Clear the terminal
alias c='clear'
# Beautiful Cat
# alias cat='colorize'
# Prevent the system from sleeping for one hour.
alias cafe='caffeinate -t 3600 &'
# Display a clock on the upper right hand side of the terminal.
alias clock='while sleep 1;do tput sc;tput cup 0 $(($(tput cols)-29));date;tput rc;done &'
# Open mac vim
alias mvim='open -a macvim'
# Open tmux with 356 colors
#alias tmux="TERM=screen-256color-bce tmux"
alias mux="tmuxinator"
# Using neovim
alias vim="nvim"
alias vimdiff="nvim -d"
alias ivm="nvim"
# load vim with very basic settings (way faster)
alias vi="vi -u ~/.vimrc"
# dotfiles
alias cdd="cd $HOME/.dotfiles"
# weather
alias weather="curl wttr.in/montreal"
# suffix alias
alias -s md=nvim
#docker
# List all exited containers
alias dpsa="docker ps -aq -f status=exited"
# Remove stopped containers
alias drms="docker ps -aq --no-trunc | xargs docker rm"
# Remove dangling/untagged images
alias drmd="docker images -q --filter dangling=true | xargs docker rmi"
# hub alias
eval "$(hub alias -s)"
