# source <(kubectl completion zsh)
# source <(helm completion zsh)


function kubectl() {
    if ! type __start_kubectl >/dev/null 2>&1; then
        source <(command kubectl completion zsh)
    fi

    command kubectl "$@"
}

function helm() {
    if ! type __start_helm >/dev/null 2>&1; then
        source <(command helm completion zsh)
    fi

    command helm "$@"
}

# autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C $(which terraform) terraform
complete -o nospace -C $(which vault) vault
