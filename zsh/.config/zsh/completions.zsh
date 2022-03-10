# +---------+
# | General |
# +---------+

# Load more completions
# (kubectl > 1.22) kubectl completion zsh > ${DOTFILES_HOME}/zsh/.config/zsh/plugins/kubectl-completion/_kubectl
fpath=(${DOTFILES_HOME}/zsh/.config/zsh/plugins/kubectl-completion $fpath)
fpath=(${DOTFILES_HOME}/zsh/.config/zsh/plugins/zsh-completions/src $fpath)

# complist give access to the keymap menuselect (should be loaded before compinit)
zmodload zsh/complist

# Use hjlk in menu selection (during completion)
# Doesn't work well with interactive mode
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# The autoload command load a file containing shell commands.
# To find this file, Zsh will look in the directories of the Zsh file search path,
# defined in the variable $fpath, and search a file called compinit.
# It doesn’t expand aliases thanks to the -U option.
# autoload -Uz compinit && compinit
autoload -U compinit; compinit
_comp_options+=(globdots) # With hidden files

autoload -U bashcompinit; bashcompinit

# autoload -U compinit; compinit
# # https://gist.github.com/ctechols/ca1035271ad134841284
# autoload -Uz compinit
# if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
# 	compinit;
# else
# 	compinit -C;
# fi;

# +---------+
# | Options |
# +---------+

# setopt GLOB_COMPLETE      # Show autocompletion menu with globs
setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.

# +---------+
# | zstyles |
# +---------+

# Ztyle pattern
# :completion:<function>:<completer>:<command>:<argument>:<tag>

# Define completers
zstyle ':completion:*' completer _extensions _complete _approximate

# Use cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME}/zsh/.zcompcache"

# Allow you to select in a menu
zstyle ':completion:*' menu select

zstyle ':completion:*' complete-options true
zstyle ':completion:*' file-sort modification

# Required for completion to be in good groups (named after the tags)
zstyle ':completion:*' group-name ''

# Autocomplete options for cd instead of directory stack
zstyle ':completion:*:*:*:cd:*' complete-options true
zstyle ':completion:*:*:*:cd:*' file-sort modification reverse
# cd will never select the parent directory
zstyle ':completion:*:*:*:cd:*' ignore-parents parent pwd

# tag format
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'
# zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'

# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# source <(kubectl completion zsh)
# source <(helm completion zsh)

# source <(command kubectl completion zsh)
# complete -F __start_kubectl k

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

complete -o nospace -C $(which terraform) terraform
complete -o nospace -C $(which vault) vault
