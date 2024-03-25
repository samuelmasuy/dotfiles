# +---------+
# | General |
# +---------+
# Ref: https://thevaluable.dev/zsh-completion-guide-examples/
#
# Load more completions
# (kubectl > 1.22) kubectl completion zsh > ${DOTFILES_HOME}/zsh/.config/zsh/plugins/kubectl-completion/_kubectl
# fpath=(${DOTFILES_HOME}/zsh/.config/zsh/plugins/kubectl-completion $fpath)
# fpath=(${DOTFILES_HOME}/zsh/.config/zsh/plugins/zsh-completions/src $fpath) # is it really needed?

# Add zsh-completions to $fpath.
fpath=(${0:h}/external/src $fpath)

# complist give access to the keymap menuselect (should be loaded before compinit)
zmodload zsh/complist
# # Up arrow:
# #   
# bindkey '^p' up-line-or-search
# bindkey '^p' up-line-or-search
# # up-line-or-search:  Open history menu.
# # up-line-or-history: Cycle to previous history line.
#
# # Down arrow:
# bindkey '^n' down-line-or-select
# bindkey '^n' down-line-or-select
#
# zle -A {.,}history-incremental-search-forward
# zle -A {.,}history-incremental-search-backward

# Use hjlk in menu selection (during completion)
# Doesn't work well with interactive mode
# bindkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey -M menuselect 'l' vi-forward-char

# Add completion for keg-only brewed curl on macOS when available.
if (( $+commands[brew] )); then
  brew_prefix=${HOMEBREW_PREFIX:-${HOMEBREW_REPOSITORY:-$commands[brew]:A:h:h}}
  # $HOMEBREW_PREFIX defaults to $HOMEBREW_REPOSITORY but is explicitly set to
  # /usr/local when $HOMEBREW_REPOSITORY is /usr/local/Homebrew.
  # https://github.com/Homebrew/brew/blob/2a850e02d8f2dedcad7164c2f4b95d340a7200bb/bin/brew#L66-L69
  [[ $brew_prefix == '/usr/local/Homebrew' ]] && brew_prefix=$brew_prefix:h
  fpath=($brew_prefix/opt/curl/share/zsh/site-functions(/N) $fpath)
  unset brew_prefix
fi

# The autoload command load a file containing shell commands.
# To find this file, Zsh will look in the directories of the Zsh file search path,
# defined in the variable $fpath, and search a file called compinit.
# It doesn’t expand aliases thanks to the -U option.
# The flags -z mark the function to be autoloaded using the zsh style.
# Checking the cached .zcompdump file to see if it must be regenerated adds a noticable
# delay to zsh startup. This restricts it to once a day.
# https://carlosbecker.com/posts/speeding-up-zsh/
autoload -U bashcompinit; bashcompinit
autoload -Uz compinit
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ${ZDOTDIR}/.zcompdump) ]; then
  compinit
else
  compinit -C
fi
_comp_options+=(globdots) # With hidden files

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

# smart-case
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' '+l:|=* r:|=*'

# Autocomplete options for cd instead of directory stack
zstyle ':completion:*:*:*:cd:*' complete-options false
zstyle ':completion:*:*:*:cd:*' file-sort modification reverse
# cd will never select the parent directory
zstyle ':completion:*:*:*:cd:*' ignore-parents parent pwd
# zstyle ':completion:*:*:cd:*:*' group-order alias builtins functions commands

# tag format
# zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
# zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
# zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
# zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'
# zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'

# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
#

# +---------------+
# | custom setups |
# +---------------+
source <(kubectl completion zsh)
compdef kubecolor=kubectl
compdef k=kubectl

function helm() {
    if ! type __start_helm >/dev/null 2>&1; then
        source <(command helm completion zsh)
    fi

    command helm "$@"
}

complete -o nospace -C $(which terraform) terraform
complete -o nospace -C $(which vault) vault
