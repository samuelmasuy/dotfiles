# rex-agent-restore: fish integration.
#
# A fish port of upstream's share/rex-agent-restore/rex-agent-restore.zsh
# (upstream ships zsh/bash only). Source of truth for the behavior:
#   https://github.com/pattont/RexAgentRestore
# It does nothing outside Rex and costs one file check per prompt.
#
# - Every agent started from this shell is tagged with a per-shell token.
# - When the prompt comes back and the pane's saved chat carries this shell's
#   token, the agent has exited normally, so the saved chat is deleted.
# - On the first prompt of a pane Rex restored, the saved chat carries an
#   older shell's token, so the chat is resumed.

status is-interactive; or return 0
set -q REX_BLOCK; or return 0
set -q _rex_agent_restore_loaded; and return 0
set -g _rex_agent_restore_loaded 1

set -g _rex_agent_restore_first 1
set -g _rex_agent_restore_bin (command -v rex-agent-restore; or echo /opt/homebrew/bin/rex-agent-restore)
if set -q REX_AGENT_RESTORE_STATE_DIR
    set -g _rex_agent_restore_file $REX_AGENT_RESTORE_STATE_DIR/panes/
else if set -q XDG_STATE_HOME
    set -g _rex_agent_restore_file $XDG_STATE_HOME/rex-agent-restore/panes/
else
    set -g _rex_agent_restore_file $HOME/.local/state/rex-agent-restore/panes/
end
set -g _rex_agent_restore_file $_rex_agent_restore_file(string replace 'block:' '' $REX_BLOCK).json

# A shell started inside another shell in the same pane (running `fish` by
# hand, for example) must not resume the pane's chat.
if test "$_REX_AGENT_RESTORE_OWNER" = "$REX_BLOCK"
    set -g _rex_agent_restore_nested 1
else
    set -g _rex_agent_restore_nested 0
    set -gx _REX_AGENT_RESTORE_OWNER $REX_BLOCK
end
set -gx REX_AGENT_RESTORE_SHELL_TOKEN "$fish_pid-$(random)-$(random)-$(date +%s)"

# Did the agent end because something killed it, rather than because you quit
# it? When Rex shuts down the agent is hung up on (129). When the Mac logs out
# or restarts, every process gets SIGTERM (143) and then SIGKILL (137): the
# agent exits, but an interactive shell ignores SIGTERM, so its prompt comes
# back for a moment first. Either way the chat must be kept so it can resume.
function __rex_agent_restore_killed --argument-names st
    contains -- "$st" 129 137 143
end

function __rex_agent_restore_run
    set -l plan (command $_rex_agent_restore_bin restore-plan 2>/dev/null)
    if test $status -ne 0
        return 0
    end
    set -l mode $plan[1]
    set -l desc $plan[2]
    set -l cmd $plan[3]
    if test -z "$cmd" -o "$cmd" = "$plan"
        return 0
    end

    switch $mode
        case off
            return 0
        case prompt
            echo "rex-agent-restore: press Enter to resume this pane's chat, or clear the line to skip."
            commandline $cmd
            return 0
    end

    set_color 555555
    echo "rex-agent-restore: $desc"
    set_color normal
    eval "$cmd"
    set -l st $status
    # The chat had its chance. Keep it only if the agent was killed.
    if not __rex_agent_restore_killed $st
        command rm -f -- $_rex_agent_restore_file
    end
end

function __rex_agent_restore_precmd --on-event fish_prompt
    set -l st $status
    if test -e $_rex_agent_restore_file
        set -l body (cat $_rex_agent_restore_file 2>/dev/null)
        if test -n "$REX_AGENT_RESTORE_SHELL_TOKEN"; and string match -q -- "*\"shell_token\":\"$REX_AGENT_RESTORE_SHELL_TOKEN\"*" "$body"
            # An agent started from this shell has exited.
            if not __rex_agent_restore_killed $st
                command rm -f -- $_rex_agent_restore_file
            end
        else if test "$_rex_agent_restore_first" = 1 -a "$_rex_agent_restore_nested" = 0
            set -g _rex_agent_restore_first 0
            __rex_agent_restore_run
        end
    end
    set -g _rex_agent_restore_first 0
end
