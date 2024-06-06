#!/usr/bin/env bash
set -e

echo "**************************************************************************"
echo "********************Home directories setup...*****************************"
echo "**************************************************************************"
mkdir -p "$HOME/src/github.com"
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.config/git"
mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.local/share"
mkdir -p "$HOME/.local/share/zsh"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/state"
mkdir -p "$HOME/.cache"

echo "**************************************************************************"
echo "******************Homebrew Install...*************************************"
echo "**************************************************************************"
command -v brew >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

echo "**************************************************************************"
echo "******************Deps Install...*****************************************"
echo "**************************************************************************"
brew install git stow

echo "**************************************************************************"
echo "******************Dotfiles Install...*************************************"
echo "**************************************************************************"
git clone --bare git@github.com:samuelmasuy/dotfiles.git "$HOME/.dotfiles.git"
pushd "$HOME/.dotfiles.git"
git config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
read -rp "Enter the email for dotfiles : " email
git config user.email "$email"
git fetch
git for-each-ref --format='%(refname:short)' refs/heads | xargs git branch -D
git worktree add master master
cd master
./install
popd

echo "**************************************************************************"
echo "******************Application and tool installation...********************"
echo "**************************************************************************"
pushd "$HOME/.dotfiles.git/master"
brew bundle || true
popd

asdf install
gh extension install github/gh-copilot

echo "**************************************************************************"
echo "**********************Neovim stuff...*************************************"
echo "**************************************************************************"
sudo gem install neovim
npm install -g neovim

bat cache --build

# hide bluesnooze, unhide: defaults delete com.oliverpeate.Bluesnooze hideIcon && killall Bluesnooze
# defaults write com.oliverpeate.Bluesnooze hideIcon -bool true && killall Bluesnooze

echo "Almost Done! Just do that: https://github.com/fabianishere/pam_reattach"
