function ggf -- description 'Git push with force-with-lease on the current branch or the branch given as an argument'
    if test (count $argv) -ne 1
        set b (git_current_branch)
    else
        set b $argv[1]
    end
    git push --force-with-lease origin $b
end
