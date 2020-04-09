#!/usr/bin/env bash
set -e

DOTFILES_HOME=$HOME/.dotfiles

echo "**************************************************************************"
echo "********************Home directories setup...*****************************"
echo "**************************************************************************"
mkdir -p $HOME/src/github.com
mkdir -p $HOME/bin
mkdir -p $HOME/pkg

echo "**************************************************************************"
echo "******************Command line tooling install...***********************************"
echo "**************************************************************************"
# TODO find how to install tooling without having to install XCode
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
[ ! -d "$DOTFILES_HOME" ] && git clone --recursive git@github.com:samuelmasuy/dotfiles.git $DOTFILES_HOME
ln -s $DOTFILES_HOME $HOME/.dotfiles

echo "**************************************************************************"
echo "******************Application and tool installation...********************"
echo "**************************************************************************"
brew tap Homebrew/bundle
brew bundle --file=$DOTFILES_HOME/Brewfile

echo "**************************************************************************"
echo "*********************Removing dotfiles...*********************************"
echo "**************************************************************************"
[ -d "$HOME/.config" ] && rm -rf $HOME/.config
[ -d "$HOME/.tmux" ] && rm -rf $HOME/.tmux
[ -d "$HOME/.zsh" ] && rm -rf $HOME/.zsh
[ -f "$HOME/.bash_profile" ] && rm -f $HOME/.bash_profile
[ -f "$HOME/.gitconfig" ] && rm -f $HOME/.gitconfig
[ -f "$HOME/.gitignore" ] && rm -f $HOME/.gitignore
[ -f "$HOME/.ideavimrc" ] && rm -f $HOME/.ideavimrc
[ -f "$HOME/.tmux.conf" ] && rm -f $HOME/.tmux.conf
[ -f "$HOME/.vimrc" ] && rm -f $HOME/.vimrc
[ -f "$HOME/.zshrc" ] && rm -f $HOME/.zshrc
[ -f "$HOME/Documents/mysnazzy.itermcolors" ] && rm -f $HOME/Documents/mysnazzy.itermcolors

echo "**************************************************************************"
echo "**********************Install Plug for nvim...****************************"
echo "**************************************************************************"
sudo pip install --upgrade neovim
sudo pip3 install --upgrade neovim
curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "**************************************************************************"
echo "*********************Symlinking dotfiles...*******************************"
echo "**************************************************************************"
ln -s $DOTFILES_HOME/bash_profile $HOME/.bash_profile
ln -s $DOTFILES_HOME/basic_vimrc $HOME/.vimrc
ln -s $DOTFILES_HOME/gitignore $HOME/.gitignore
ln -s $DOTFILES_HOME/ideavimrc $HOME/.ideavimrc
ln -s $DOTFILES_HOME/iterm/mysnazzy.itermcolors $HOME/Documents/mysnazzy.itermcolors
ln -s $DOTFILES_HOME/tmux $HOME/.tmux
ln -s $DOTFILES_HOME/tmux.conf $HOME/.tmux.conf
ln -s $DOTFILES_HOME/vimrc $HOME/.config/nvim/init.vim
ln -s $DOTFILES_HOME/coc-settings.json $HOME/.config/nvim/coc-settings.json
ln -s $DOTFILES_HOME/zsh/config $HOME/.zsh
ln -s $DOTFILES_HOME/zshrc $HOME/.zshrc
ln -s $DOTFILES_HOME/zsh/theme/p10k.zsh $HOME/.zsh/p10k.zsh

echo "**************************************************************************"
echo "***********************Install nVim plugins...**************************"
echo "**************************************************************************"
nvim -c "PlugInstall" -c q -c q
nvim -c "UpdateRemotePlugins" -c q

echo "**************************************************************************"
echo "*********************Change shell to zsh...*******************************"
echo "**************************************************************************"
command -v zsh | sudo tee -a /etc/shells
sudo chsh -s "$(command -v zsh)" "${USER}"

echo "**************************************************************************"
echo "*********************Gems install...**************************************"
echo "**************************************************************************"
sudo gem install tmuxinator
sudo gem install neovim
sudo gem install nokogiri

echo "**************************************************************************"
echo "*********************Npm install...***************************************"
echo "**************************************************************************"
npm install -g typescript
npm install -g neovim
npm install -g npm
npm install -g fixjson
npm install -g remark-cli
npm install -g git-removed-branches
npm install -g markdown2confluence
npm install -g serverless
npm install -g yarn
# go get -u mvdan.cc/sh/cmd/shfmt

echo "**************************************************************************"
echo "*********************Hammerspoon install...*******************************"
echo "**************************************************************************"
mkdir -p $HOME/.hammerspoon/Spoons
git clone https://github.com/jasonrudolph/ControlEscape.spoon.git $HOME/.hammerspoon/Spoons/ControlEscape.spoon
cd $HOME/.hammerspoon/Spoons/ControlEscape.spoon
script/setup
script/remap-caps-lock-to-control

echo "Done!"
