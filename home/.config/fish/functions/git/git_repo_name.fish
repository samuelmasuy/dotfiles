function git_repo_name --description 'Get the name of the current git repository'
    set repo_path (git rev-parse --show-toplevel 2>/dev/null)
    if test -n "$repo_path"
        basename $repo_path
    end
end
