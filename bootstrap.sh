#!/usr/bin/env bash
set -e

DOTFILES_HOME=$HOME/.dotfiles
source zsh/dot-zshenv

echo "**************************************************************************"
echo "********************Home directories setup...*****************************"
echo "**************************************************************************"
mkdir -p $HOME/src/github.com
mkdir -p $HOME/bin
mkdir -p $HOME/pkg

echo "**************************************************************************"
echo "******************Command line tooling install...***********************************"
echo "**************************************************************************"
command -v gcc >/dev/null 2>&1 && xcode-select --install || true
command -v gcc >/dev/null 2>&1 || { echo >&2 "I require gcc, but it's not installed. Aborting."; exit 1; }

echo "**************************************************************************"
echo "******************Homebrew Install...*************************************"
echo "**************************************************************************"
command -v brew >/dev/null 2>&1 || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "**************************************************************************"
echo "******************Git Install...******************************************"
echo "**************************************************************************"
command -v git >/dev/null 2>&1 || brew install git

echo "**************************************************************************"
echo "******************Dotfiles Install...*************************************"
echo "**************************************************************************"
[ ! -d "$DOTFILES_HOME" ] && git clone --recurse-submodules -j8 git@github.com:samuelmasuy/dotfiles.git $DOTFILES_HOME

echo "**************************************************************************"
echo "******************Application and tool installation...********************"
echo "**************************************************************************"
brew tap Homebrew/bundle
brew bundle --file=$DOTFILES_HOME/Brewfile

echo "**************************************************************************"
echo "******************ASDF Installation...************************************"
echo "**************************************************************************"
asdf plugin add kubectl https://github.com/Banno/asdf-kubectl.git
asdf plugin add vault https://github.com/Banno/asdf-hashicorp.git
asdf plugin add terraform https://github.com/Banno/asdf-hashicorp.git
asdf plugin add packer https://github.com/Banno/asdf-hashicorp.git
asdf plugin add helm https://github.com/Antiarchitect/asdf-helm.git
asdf install
echo "**************************************************************************"
echo "*********************Change shell to zsh...*******************************"
echo "**************************************************************************"
command -v zsh | sudo tee -a /etc/shells
sudo chsh -s "$(command -v zsh)" "${USER}"

echo "**************************************************************************"
echo "*********************Symlinking dotfiles...*******************************"
echo "**************************************************************************"
mkdir -p $XDG_CONFIG_HOME/docker
mkdir -p $XDG_CONFIG_HOME/zsh
mkdir -p $XDG_DATA_HOME/cargo
mkdir -p $XDG_DATA_HOME/gem
mkdir -p $XDG_DATA_HOME/npm
mkdir -p $XDG_DATA_HOME/rustup
mkdir -p $XDG_DATA_HOME/tig
mkdir -p $XDG_DATA_HOME/tmux
mkdir -p $XDG_DATA_HOME/zoxide
mkdir -p $XDG_DATA_HOME/zsh
mkdir -p $XDG_CACHE_HOME/gem


defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
echo "Almost Done! Run ./install and Just do that: https://blog.birkhoff.me/make-sudo-authenticate-with-touch-id-in-a-tmux/"

# echo "**************************************************************************"
# echo "**********************neovim stuff...*************************************"
# echo "**************************************************************************"
# sudo pip3 install --upgrade neovim
# sudo gem install neovim
# npm install -g neovim
