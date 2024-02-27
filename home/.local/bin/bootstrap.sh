#!/usr/bin/env bash
set -e

echo "**************************************************************************"
echo "********************Home directories setup...*****************************"
echo "**************************************************************************"
mkdir -p "$HOME/src/github.com"
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/share"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/state"
mkdir -p "$HOME/.cache"

echo "**************************************************************************"
echo "******************Command line tooling install...***********************************"
echo "**************************************************************************"
command -v gcc >/dev/null 2>&1 && xcode-select --install || true
command -v gcc >/dev/null 2>&1 || {
	echo >&2 "I require gcc, but it's not installed. Aborting."
	exit 1
}

echo "**************************************************************************"
echo "******************Homebrew Install...*************************************"
echo "**************************************************************************"
command -v brew >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "**************************************************************************"
echo "******************Git Install...******************************************"
echo "**************************************************************************"
command -v git >/dev/null 2>&1 || brew install git

echo "**************************************************************************"
echo "******************Dotfiles Install...*************************************"
echo "**************************************************************************"
git clone --bare git@github.com:samuelmasuy/dotfiles.git "$HOME/.dotfiles.git"
pushd "$HOME/.dotfiles.git"
git config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
read -rsp "Enter the email for dotfiles : " email
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
brew bundle --file="$HOME/.local/share/brewfile/Brewfile"

echo "**************************************************************************"
echo "******************ASDF Installation...************************************"
echo "**************************************************************************"
while read -r plugin_line; do
	asdf plugin-add $(awk '{print $1}' <<<"$plugin_line")
done <"$HOME/.tool-versions"
asdf install

# defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"

echo "Almost Done! Run ./install and Just do that: https://blog.birkhoff.me/make-sudo-authenticate-with-touch-id-in-a-tmux/"

# echo "**************************************************************************"
# echo "**********************neovim stuff...*************************************"
# echo "**************************************************************************"
sudo pip3 install --upgrade neovim
sudo gem install neovim
npm install -g neovim

# hide bluesnooze, unhide: defaults delete com.oliverpeate.Bluesnooze hideIcon && killall Bluesnooze
defaults write com.oliverpeate.Bluesnooze hideIcon -bool true && killall Bluesnooze
