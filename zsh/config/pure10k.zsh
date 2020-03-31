() {
  emulate -L zsh

  # Custom prompt segment for user@host that emulates Pure.
  function pure10k_user_host() {
    if [[ $UID -eq 0 ]]; then
      echo -E '%F{white}%n%f%F{242}@%m%f'
    elif [[ -n $SSH_CONNECTION  ]]; then
      echo -E '%F{242}%n@%m%f'
    fi
  }

  typeset -ga POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
      dir                       # current directory
      vcs                       # git status
      custom_pure10k_user_host  # user@host
      command_execution_time    # previous command wall time
      newline                   # \n
      # virtualenv                # python virtual environment
  )
  typeset -g POWERLEVEL9K_DISABLE_RPROMPT=true

  # Empty line before the prompt.
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=false

  # Prompt symbol: '❮' when vicmd keymap is active, '❯` otherwise; red on error, green on success.
  local p='%F{%(?.green.red)}${${${KEYMAP:-0}:#vicmd}:+❯}${${$((!${#${KEYMAP:-0}:#vicmd})):#0}:+❮}%f '
  typeset -g POWERLEVEL9K_LEFT_SEGMENT_END_SEPARATOR="%1(l. .)$p"

  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=' '
  typeset -g POWERLEVEL9K_WHITESPACE_BETWEEN_{LEFT,RIGHT}_SEGMENTS=

  typeset -g POWERLEVEL9K_VIRTUALENV_BACKGROUND=none
  typeset -g POWERLEVEL9K_VIRTUALENV_FOREGROUND=242
  typeset -g POWERLEVEL9K_PYTHON_ICON=

  typeset -g POWERLEVEL9K_DIR_{ETC,HOME,HOME_SUBFOLDER,DEFAULT}_BACKGROUND=none
  typeset -g POWERLEVEL9K_DIR_{HOME,HOME_SUBFOLDER,ETC,DEFAULT}_FOREGROUND=blue
  typeset -g POWERLEVEL9K_{ETC,FOLDER,HOME,HOME_SUB}_ICON=

  # Make git prompt grey in all states. Also make stale prompts appear indistinguishable from
  # fresh ones. This is unlikely to be desired by anyone but that's how Pure does it.
  #
  # typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED,LOADING,ACTIONFORMAT}_FOREGROUND=242

  # Make ahead/behind arrows cyan in every state including when the git prompt is stale.
  # This is unlikely to be desired by anyone but that's how Pure does it.
  #
  # typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED,LOADING}_{INCOMING,OUTGOING}_CHANGESFORMAT_FOREGROUND=cyan

  # Disable async loading indicator to make directories that aren't git repositories
  # indistinguishable from large git repositories without known state. This is unlikely
  # to be desired by anyone but that's how Pure does it.
  #
  # typeset -g POWERLEVEL9K_VCS_LOADING_TEXT=

  # Disable background.
  #
  # typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED,LOADING}_BACKGROUND=none

  # Don't show remote branch, current tag or stashes.
  #
  # typeset -g POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-untracked git-aheadbehind)

  # Disable most icons.
  #
  # typeset -g POWERLEVEL9K_VCS_{GIT,GIT_GITHUB,GIT_BITBUCKET,GIT_GITLAB,BRANCH}_ICON=

  # When in detached HEAD state, show '@commit' where branch normally goes.
  #
  # typeset -g POWERLEVEL9K_VCS_COMMIT_ICON='@'

  # Don't show staged, unstaged, untracked indicators.
  #
  # typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED}_ICON=$'\b'

  # Show '*' when there are staged, unstaged or untracked files.
  # typeset -g POWERLEVEL9K_VCS_DIRTY_ICON='✗'

  # Show '⇣' if local branch is behind remote.
  # typeset -g POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='⇣'

  # Show '⇡' if local branch is ahead of remote.
  # typeset -g POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='⇡'

  # Don't show the number of commits next to the ahead/behind arrows.
  #
  # typeset -g POWERLEVEL9K_VCS_{COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=1

  # typeset -g POWERLEVEL9K_CUSTOM_PURE10K_USER_HOST=pure10k_user_host
  # typeset -g POWERLEVEL9K_CUSTOM_PURE10K_USER_HOST_BACKGROUND=none
  # typeset -g POWERLEVEL9K_CUSTOM_PURE10K_USER_HOST_FOREGROUND=none

  # Show previous command wall time only if it's >= 5s.
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=5
  # Don't show fractional seconds.
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=none
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=yellow
  typeset -g POWERLEVEL9K_EXECUTION_TIME_ICON=
}
