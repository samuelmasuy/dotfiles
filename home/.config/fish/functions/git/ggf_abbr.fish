function ggf_abbr --description 'Git push with force-with-lease on the current branch'
    set b (git_current_branch)
    echo "git push --force-with-lease origin $b"
end
