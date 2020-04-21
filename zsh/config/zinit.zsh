export ZSH_CACHE_DIR="${XDG_CACHE_HOME}/zshcache"

zinit lucid trigger-load'!man' for is-snippet \
  'OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh'

zinit ice lucid
zinit snippet OMZ::lib/git.zsh

zinit ice wait atload"unalias grv" lucid
zinit snippet OMZ::plugins/git/git.plugin.zsh

zinit ice wait lucid
zinit snippet OMZ::plugins/kubectl/kubectl.plugin.zsh

zinit ice wait lucid as"completion"
zinit snippet OMZ::plugins/docker/_docker

zinit light 'rupa/z'

zinit ice depth=1; zinit light romkatv/powerlevel10k

# don't add wait, messes with zsh-autosuggest
# zinit lucid atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" for \
#   'zdharma/fast-syntax-highlighting'

zinit light zsh-users/zsh-history-substring-search

# Keybindings for substring search plugin. Maps up and down arrows.
bindkey -M main '^[OA' history-substring-search-up
bindkey -M main '^[OB' history-substring-search-down
bindkey -M main '^[[A' history-substring-search-up
bindkey -M main '^[[B' history-substring-search-up
