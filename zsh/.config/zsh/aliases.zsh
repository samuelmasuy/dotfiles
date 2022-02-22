# cd in the previous directory.
alias cdp="cd ~-"
alias ..='cd -- ..'
alias ...='cd -- ../..'
# Display all files and directories including the hidden ones, with precision.
# Make the terminal say all the files and directories.
alias lt="/bin/ls | say -va"
# exa love
# alias ls='exa'
# alias la='exa -la --sort modified'
alias l='exa -a --git-ignore'
alias ll='exa -la --git-ignore --git --sort modified'
# or not
alias ls='ls -G'
alias la='ls -larth'
# alias la='exa -la --sort modified'
# alias l='exa -a --git-ignore'
# alias ll='exa -la --git-ignore --sort modified'

# confirm && verbose
alias	cp="cp -i"
alias	mv="mv -i"
# alias	rm="rm -v"
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
# Open tmux
alias tmux="tmux -f ${XDG_CONFIG_HOME:-$HOME/.config}/tmux/tmux.conf"
alias mux="tmuxinator"
# Using neovim
alias vim="nvim"
alias vimdiff="nvim -d"
alias ivm="nvim"
# load vim with very basic settings (way faster)
alias vi="vi -u ${XDG_CONFIG_HOME:-$HOME/.config}/vim/.vimrc"
# dotfiles
alias cdd="cd $HOME/.dotfiles"
# weather
alias weath="curl wttr.in/montreal"
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
# tools alias
alias gpb="gpsup"
alias gprco="git pr checkout"
# bat > cat
alias cat="bat"
# docker console
alias lzd='lazydocker'
# prefer ripgrep, but I always type ag
alias ag='rg'
# spotify
alias sp="spotify"
alias spn="spotify next"
alias spp="spotify prev"
alias spst="spotify status"

alias j8='export JAVA_HOME=$(/usr/libexec/java_home -v 1.8); java -version'
alias j11='export JAVA_HOME=$(/usr/libexec/java_home -v 11); java -version'

# Symlink all dotfiles like magic
alias dotfilesInstall="$DOTFILES_HOME/install"
