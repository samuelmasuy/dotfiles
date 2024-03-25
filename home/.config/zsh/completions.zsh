# +---------+
# | General |
# +---------+
# Ref: https://thevaluable.dev/zsh-completion-guide-examples/

# complist give access to the keymap menuselect (should be loaded before compinit)
zmodload zsh/complist

# Add completion for brewed apps
if type brew &>/dev/null; then
  fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
fi

# Load and initialize the completion system ignoring insecure directories with a
# cache time of 20 hours, so it should almost always regenerate the first time a
# shell is opened each day.
autoload -Uz compinit
_comp_path="${XDG_CACHE_HOME}/zsh/zcompdump"
# #q expands globs in conditional expressions
if [[ $_comp_path(#qNmh-20) ]]; then
  # -C (skip function check) implies -i (skip security check).
  compinit -C -d "$_comp_path"
else
  mkdir -p "$_comp_path:h"
  compinit -i -d "$_comp_path"
  # Keep $_comp_path younger than cache time even if it isn't regenerated.
  touch "$_comp_path"
fi
autoload -U +X bashcompinit && bashcompinit
unset _comp_path

_comp_options+=(globdots) # With hidden files

# # +---------+
# # | Options |
# # +---------+
# # setopt GLOB_COMPLETE      # Show autocompletion menu with globs
setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.
setopt ALWAYS_TO_END        # Move cursor to the end of a completed word.
setopt PATH_DIRS            # Perform path search even on command names with slashes.
setopt AUTO_MENU            # Show completion menu on a successive tab press.
setopt AUTO_PARAM_SLASH     # If completed parameter is a directory, add a trailing slash.
setopt EXTENDED_GLOB        # Needed for file modification glob modifiers with compinit.
# unsetopt MENU_COMPLETE    # Do not autoselect the first completion entry.
unsetopt FLOW_CONTROL       # Disable start/stop characters in shell editor.

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

# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
#

# +---------------+
# | custom setups |
# +---------------+
if type kubectl &>/dev/null; then
  source <(kubectl completion zsh)
  compdef kubecolor=kubectl
  compdef k=kubectl
fi

if type helm &>/dev/null; then
  function helm() {
      if ! type __start_helm >/dev/null 2>&1; then
          source <(command helm completion zsh)
      fi

      command helm "$@"
  }
fi

if type vault &>/dev/null; then
  complete -o nospace -C $(which vault) vault
fi
if type terraform &>/dev/null; then
  complete -o nospace -C $(which terraform) terraform
fi
