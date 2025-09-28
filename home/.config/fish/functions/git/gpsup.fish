function gpsup -- description 'Git push with setting upstream on the current branch'
    git push --set-upstream origin (git_current_branch)
end
