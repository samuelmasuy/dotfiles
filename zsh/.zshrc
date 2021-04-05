# zmodload zsh/zprof
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

hash -d c=$XDG_CONFIG_HOME
hash -d d=$XDG_DATA_HOME

# https://gist.github.com/ctechols/ca1035271ad134841284
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;

source <(antibody init)

antibody bundle romkatv/powerlevel10k

antibody bundle robbyrussell/oh-my-zsh path:lib/completion.zsh
antibody bundle robbyrussell/oh-my-zsh path:lib/directories.zsh
antibody bundle robbyrussell/oh-my-zsh path:lib/git.zsh

antibody bundle robbyrussell/oh-my-zsh path:plugins/git
# antibody bundle robbyrussell/oh-my-zsh path:plugins/mvn
antibody bundle robbyrussell/oh-my-zsh path:plugins/docker
antibody bundle robbyrussell/oh-my-zsh path:plugins/zsh_reload
antibody bundle robbyrussell/oh-my-zsh path:plugins/colored-man-pages

antibody bundle zsh-users/zsh-completions

antibody bundle zdharma/fast-syntax-highlighting
antibody bundle zsh-users/zsh-history-substring-search

source ${XDG_CONFIG_HOME}/zsh/config/exports.zsh #1
source ${XDG_CONFIG_HOME}/zsh/config/asdf.zsh #2
source ${XDG_CONFIG_HOME}/zsh/config/aliases.zsh
source ${XDG_CONFIG_HOME}/zsh/config/functions.zsh
source ${XDG_CONFIG_HOME}/zsh/config/completions.zsh
[[ -f ${XDG_CONFIG_HOME}/zsh/config/secrets.zsh ]] && source ${XDG_CONFIG_HOME}/zsh/config/secrets.zsh
[[ -f ${XDG_CONFIG_HOME}/zsh/config/work.zsh ]] && source ${XDG_CONFIG_HOME}/zsh/config/work.zsh


# Use the Vi-like keybindings
bindkey -v
export KEYTIMEOUT=1 # short switch between modes
# bindkey '^[OA' history-substring-search-up
# bindkey '^[OB' history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=white'

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data

zstyle ':completion:*:cd:*' ignore-parents parent pwd # cd will never select the parent directory
# zstyle ':completion:*' menu select
# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# source /usr/local/bin/virtualenvwrapper.sh

# if type brew &>/dev/null; then
#   FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

#   autoload -Uz compinit
#   compinit
# fi
#
eval "$(zoxide init zsh)"

. $(brew --prefix asdf)/asdf.sh

[[ -f ${XDG_CONFIG_HOME}/zsh/config/fzf.zsh ]] && source ${XDG_CONFIG_HOME}/zsh/config/fzf.zsh

# To customize prompt, run `p10k configure`
[[ ! -f ${XDG_CONFIG_HOME}/zsh/config/p10k.zsh ]] || source ${XDG_CONFIG_HOME}/zsh/config/p10k.zsh
# zprof

