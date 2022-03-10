# +---------+
# | General |
# +---------+
# Ref: https://thevaluable.dev/zsh-completion-guide-examples/
#
# Load more completions
# (kubectl > 1.22) kubectl completion zsh > ${DOTFILES_HOME}/zsh/.config/zsh/plugins/kubectl-completion/_kubectl
fpath=(${DOTFILES_HOME}/zsh/.config/zsh/plugins/kubectl-completion $fpath)
# fpath=(${DOTFILES_HOME}/zsh/.config/zsh/plugins/zsh-completions/src $fpath) # is it really needed?

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
# The flags -z mark the function to be autoloaded using the zsh style.
# Checking the cached .zcompdump file to see if it must be regenerated adds a noticable
# delay to zsh startup. This restricts it to once a day.
# https://carlosbecker.com/posts/speeding-up-zsh/
autoload -Uz compinit
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ${ZDOTDIR}/.zcompdump) ]; then
  compinit
else
  compinit -C
fi
_comp_options+=(globdots) # With hidden files

autoload -U bashcompinit; bashcompinit

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

# +---------------+
# | custom setups |
# +---------------+
function helm() {
    if ! type __start_helm >/dev/null 2>&1; then
        source <(command helm completion zsh)
    fi

    command helm "$@"
}

complete -o nospace -C $(which terraform) terraform
complete -o nospace -C $(which vault) vault
