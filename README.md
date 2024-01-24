# dotfiles

Managed based on https://www.atlassian.com/git/tutorials/dotfiles

<details>
<summary>Install!</summary>

```sh
git clone --bare git@github.com:samuelmasuy/dotfiles.git "$HOME/.dotfiles.git"
pushd "$HOME/.dotfiles.git"
git config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
git fetch
git for-each-ref --format='%(refname:short)' refs/heads | xargs git branch -D
git worktree add master master
popd
pushd "$HOME"
git --git-dir="$HOME/.dotfiles.git/worktrees/master" --work-tree="$HOME" checkout .
git --git-dir="$HOME/.dotfiles.git/worktrees/master" --work-tree="$HOME" config status.showUntrackedFiles no
popd
```

</details>

hello
