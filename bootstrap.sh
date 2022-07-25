#!/usr/bin/env bash
set -e

DOTFILES_HOME=$HOME/.dotfiles
source zsh/dot-zshenv

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
[ ! -d "$DOTFILES_HOME" ] && git clone --recurse-submodules -j8 git@github.com:samuelmasuy/dotfiles.git "$DOTFILES_HOME"

echo "**************************************************************************"
echo "******************Application and tool installation...********************"
echo "**************************************************************************"
brew bundle --file="$DOTFILES_HOME/Brewfile"

echo "**************************************************************************"
echo "******************ASDF Installation...************************************"
echo "**************************************************************************"
asdf plugin add kubectl https://github.com/Banno/asdf-kubectl.git
asdf plugin add helm https://github.com/Antiarchitect/asdf-helm.git
asdf install

# defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"

echo "Almost Done! Run ./install and Just do that: https://blog.birkhoff.me/make-sudo-authenticate-with-touch-id-in-a-tmux/"

# echo "**************************************************************************"
# echo "**********************neovim stuff...*************************************"
# echo "**************************************************************************"
# sudo pip3 install --upgrade neovim
# sudo gem install neovim
# npm install -g neovim
