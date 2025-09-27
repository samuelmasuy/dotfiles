#!/usr/bin/env fish

# cd in the previous directory.
abbr -a -- cdp 'cd ~-'
abbr -a -- '..' 'cd -- ..'
abbr -a -- '...' 'cd -- ../..'
abbr -a -- '....' 'cd -- ../../..'
# Use z to jump around
abbr -a -- cd 'z'
# z with fzf
abbr -a -- zz 'zi'

# eza for ls
alias l='eza -a --git-ignore'
alias lf='eza -lF --color=always | grep -v /'
alias lh='eza -dl .* --group-directories-first'
alias ll='eza -la --no-permissions --no-user --git-ignore --git --sort modified --icons always'
alias la='eza -la --git --sort modified --icons always'
# or not
alias ls='/bin/ls -AG'
# Make the terminal say all the files and directories.
alias lt="/bin/ls | say -va"

# confirm && verbose
abbr -a -- mv 'mv -i'
# Open the given directory in finder.
abbr -a -- f 'open .'
# Clear the terminal
abbr -a -- c 'clear'
# bat > cat
abbr -a -- cat 'bat'
# Prevent the system from sleeping for one hour.
abbr -a -- cafe 'caffeinate -t 3600 &'
# Open tmux
function tmux
    set -l config_dir (test -n "$XDG_CONFIG_HOME"; and echo $XDG_CONFIG_HOME; or echo $HOME/.config)
    command tmux -f $config_dir/tmux/tmux.conf $argv
end
# Using neovim
alias vim="nvim"
alias vimdiff="nvim -d"
alias ivm="nvim"
# load vim with very basic settings
function vi
    set -l config_dir (test -n "$XDG_CONFIG_HOME"; and echo $XDG_CONFIG_HOME; or echo $HOME/.config)
    command vi -u $config_dir/vim/.vimrc $argv
end
# upgrade neovim nightly
alias upgrade-neovim-nightly='mise uninstall neovim:neovim@nightly && mise install neovim:neovim@nightly'
# dotfiles
abbr -a -- cdd 'cd $DOTFILES_HOME'

# weather
abbr -a -- weather 'curl wttr.in/montreal'
# kill
abbr -a -- killseg 'kill -s SIGSEGV $$'

# tldr with fzf
alias tldrf='tldr --list | fzf --preview "tldr --color=always {1}" --preview-window=right,70% | xargs tldr'

# +-----+
# | Git |
# +-----+
abbr -a -- g 'git'
abbr -a -- gl 'git pull'
abbr -a -- gst 'git status'
abbr -a -- ga 'git add'
abbr -a -- gc 'git commit -v -s'
abbr -a -- 'gc!' 'git commit -v -s --amend'
abbr -a -- 'gcn!' 'git commit -v -s --no-edit --amend'
abbr -a -- gp 'git push'
abbr -a -- gbr 'git branch --sort=-committerdate | fzf --header "Checkout Recent Branch" --preview "git diff --color=always {1}" --pointer="" | xargs git checkout'

abbr -a -- ci 'gh pr checks'

abbr -a -- gpr 'gh prs'
abbr -a -- gprc 'gh pr checks -w'

# +-----+
# | k8s |
# +-----+
if command -v kubecolor >/dev/null 2>&1
    alias kubectl="kubecolor"
end
alias k=kubectl
abbr -a -- ks 'kubectl -n kube-system'
alias kn=kubens
alias kx=kubectx
abbr -a -- minikube 'DOCKER_DEFAULT_PLATFORM=linux/arm64/v8 minikube'

alias oc=opencode
