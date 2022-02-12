# source <(kubectl completion zsh)
# source <(helm completion zsh)

source <(command kubectl completion zsh)
alias k=kubectl
complete -F __start_kubectl k

alias kn=kubens
alias kx=kubectx

# function k() {
#     if ! type __start_kubectl >/dev/null 2>&1; then
#       complete -F __start_kubectl k
#     fi

#     command k "$@"
# }

function helm() {
    if ! type __start_helm >/dev/null 2>&1; then
        source <(command helm completion zsh)
    fi

    command helm "$@"
}

# autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C $(which terraform) terraform
complete -o nospace -C $(which vault) vault
