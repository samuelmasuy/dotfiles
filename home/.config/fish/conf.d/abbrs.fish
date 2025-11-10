# z with fzf
abbr -a -- zz zi
# cd in the previous directory.
abbr -a -- cdp 'cd ~-'
# cd to any parent directory
abbr --add dotdot --regex '^\.\.+$' --function multicd

# confirm && verbose
abbr -a -- mv 'mv -i'
# Open the given directory in finder.
abbr -a -- f 'open .'
# Clear the terminal
abbr -a -- c clear
# bat > cat
abbr -a -- cat bat
# Prevent the system from sleeping for one hour.
abbr -a -- cafe 'caffeinate -t 3600 &'
# dotfiles
abbr -a -- cdd 'cd $DOTFILES_HOME'

# weather
abbr -a -- weather 'curl wttr.in/montreal'
# kill
abbr -a -- killseg 'kill -s SIGSEGV $$'

# tldr with fzf
abbr -a -- tldrf 'tldr --list | fzf --preview "tldr --color=always {1}" --preview-window=right,70% | xargs tldr'

# +-----+
# | Git |
# +-----+
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

abbr --add ggf --function ggf_abbr
abbr --add gpsup --function gpsup_abbr

# +-----+
# | k8s |
# +-----+
# abbr -a -- k 'kubectl'
# abbr -a -- ks 'kubectl -n kube-system'
abbr -a -- kgp 'kubectl get po --no-headers | fzf | awk \'{print $1}\''
abbr -a -- kd 'kubectl get po --no-headers | fzf | awk \'{print $1}\' | xargs -n 1 kubectl describe po'
abbr -a -- klo 'kubectl get po --no-headers | fzf | awk \'{print $1}\' | xargs kubectl logs -f'
abbr -a -- ko 'kubectl get po --no-headers | fzf | awk \'{print $1}\' | xargs kubectl get po -o yaml'

abbr -a -- minikube 'DOCKER_DEFAULT_PLATFORM=linux/arm64/v8 minikube'
