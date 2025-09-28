function git_current_branch -- description 'Get the current git branch or commit hash if in detached HEAD state'
    set ref (git symbolic-ref --quiet HEAD 2>/dev/null)
    if test $status -ne 0
        if test $status -eq 128
            return
        end
        set ref (git rev-parse --short HEAD 2>/dev/null); or return
    end
    echo (string replace 'refs/heads/' '' $ref)
end
