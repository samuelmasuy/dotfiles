#!/usr/bin/env zsh

hash -d c=$XDG_CONFIG_HOME
hash -d d=$XDG_DATA_HOME

# +------------+
# | NAVIGATION |
# +------------+
setopt AUTO_CD              # Go to folder path without using cd.

setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
# setopt PUSHDMINUS

setopt CORRECT              # Spelling correction
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt EXTENDED_GLOB        # Use extended globbing syntax.

# +---------+
# | HISTORY |
# +---------+
# Do not put those exports in zshenv! (MacOS fault)
export HISTFILE="$XDG_DATA_HOME"/zsh/history # Location of history file.
export HISTSIZE=500000         # Number of lines kept in history.
export SAVEHIST=100000         # Number of lines saved in the history after logout.
setopt EXTENDED_HISTORY        # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY           # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST  # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS        # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS    # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS       # Do not display a previously found event.
setopt HIST_IGNORE_SPACE       # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS       # Do not write a duplicate event to the history file.
setopt HIST_VERIFY             # Do not execute immediately upon history expansion.
setopt INC_APPEND_HISTORY      # Add commands to HISTFILE in order of execution

# +---------+
# | ALIASES |
# +---------+
source ${XDG_CONFIG_HOME}/zsh/aliases

# +-----------+
# | FUNCTIONS |
# +-----------+
source ${XDG_CONFIG_HOME}/zsh/functions.zsh

# +-----------+
# | PROFILING |
# +-----------+
zmodload zsh/zprof

# +--------+
# | PROMPT |
# +--------+
eval "$(starship init zsh)"

# +-----------+
# | VI KEYMAP |
# +-----------+
# Use the Vi-like keybindings
bindkey -v
export KEYTIMEOUT=1 # short switch between modes

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd '^v' edit-command-line

# +------------+
# |  ETC       |
# +------------+
source ${XDG_CONFIG_HOME}/zsh/exports.zsh #1
source $ASDF_DIR/asdf.sh

[[ -f ${XDG_CONFIG_HOME}/zsh/secrets.zsh ]] && source ${XDG_CONFIG_HOME}/zsh/secrets.zsh
[[ -f ${XDG_CONFIG_HOME}/zsh/work.zsh ]] && source ${XDG_CONFIG_HOME}/zsh/work.zsh

# +------------+
# | COMPLETION |
# +------------+
source ${XDG_CONFIG_HOME}/zsh/completions.zsh

# +------+
# | JUMP |
# +------+
eval "$(zoxide init zsh)"

# +-----+
# | FZF |
# +-----+
[[ -f ${XDG_CONFIG_HOME}/zsh/fzf.zsh ]] && source ${XDG_CONFIG_HOME}/zsh/fzf.zsh

# +---------------------+
# | SYNTAX HIGHLIGHTING |
# +---------------------+
source ${DOTFILES_HOME}/zsh/.config/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh #1
fast-theme -q XDG:overlay

# +----------------+
# | HISTORY SEARCH |
# +----------------+
source ${DOTFILES_HOME}/zsh/.config/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh #2
# bindkey '^[OA' history-substring-search-up
# bindkey '^[OB' history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
# bindkey -M vicmd 'k' history-substring-search-up
# bindkey -M vicmd 'j' history-substring-search-down
bindkey -M vicmd 'gk' history-substring-search-up
bindkey -M vicmd 'gj' history-substring-search-down

# zprof
