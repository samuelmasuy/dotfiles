# Generate completions from the installed OpenCode version.
# Use a file: v2.1.2 truncates piped output at 64 KiB.
set -l completion_file (mktemp)
or return
if command opencode --completions fish >$completion_file
    source $completion_file
end
command rm -f -- $completion_file
