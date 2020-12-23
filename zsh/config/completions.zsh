source <(kubectl completion zsh)
source <(helm completion zsh)

# autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C $(which terraform) terraform
complete -o nospace -C $(which vault) vault
