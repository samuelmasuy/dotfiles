export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_RUNTIME_DIR="$TMPDIR/.run-$USER"

export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export ZSH_CACHE_DIR="${XDG_CACHE_HOME}/zsh"

export EDITOR="nvim"
export VISUAL="nvim"

# Location of history file.
export HISTFILE="$XDG_DATA_HOME"/zsh/history
# Number of lines kept in history.
export HISTSIZE=50000
# Number of lines saved in the history after logout.
export SAVEHIST=10000
