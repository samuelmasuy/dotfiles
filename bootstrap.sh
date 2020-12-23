#!/usr/bin/env bash
set -e

DOTFILES_HOME=$HOME/.dotfiles
source .profile

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
echo "******************ASDF Installation...************************************"
echo "**************************************************************************"
asdf plugin add kubectl https://github.com/Banno/asdf-kubectl.git
asdf plugin add vault https://github.com/Banno/asdf-hashicorp.git
asdf plugin add terraform https://github.com/Banno/asdf-hashicorp.git
asdf plugin add packer https://github.com/Banno/asdf-hashicorp.git
asdf plugin add helm https://github.com/Antiarchitect/asdf-helm.git
asdf install

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
ln -s $DOTFILES_HOME/.profile $HOME/.zprofile

mkdir -p $XDG_CONFIG_HOME/vim && \
  ln -s $DOTFILES_HOME/basic_vimrc $XDG_CONFIG_HOME/vim/.vimrc
mkdir -p $XDG_CONFIG_HOME/git && \
  ln -s $DOTFILES_HOME/gitignore $XDG_CONFIG_HOME/git/ignore
mkdir -p $XDG_CONFIG_HOME/nvim && \
  ln -s $DOTFILES_HOME/nvim/init.vim $XDG_CONFIG_HOME/nvim/init.vim && \
  ln -s $DOTFILES_HOME/nvim/coc-settings.json $XDG_CONFIG_HOME/nvim/coc-settings.json
mkdir -p $XDG_CONFIG_HOME/zsh && \
  ln -s $DOTFILES_HOME/zsh/.zshrc $XDG_CONFIG_HOME/zsh/.zshrc && \
  ln -s $DOTFILES_HOME/zsh/config $XDG_CONFIG_HOME/zsh/config
mkdir -p $XDG_CONFIG_HOME/npm && \
  ln -s $DOTFILES_HOME/npmrc $XDG_CONFIG_HOME/npm/npmrc && \

ln -s $DOTFILES_HOME/tmux $XDG_CONFIG_HOME/tmux

ln -s $DOTFILES_HOME/ideavimrc $HOME/.ideavimrc

ln -s $DOTFILES_HOME/iterm/mysnazzy.itermcolors $HOME/Documents/mysnazzy.itermcolors

ln -s $DOTFILES_HOME/asdf/tool-versions $HOME/.tool-versions

mkdir -p $XDG_DATA_HOME/gem
mkdir -p $XDG_CACHE_HOME/gem
mkdir -p $XDG_CONFIG_HOME/docker
mkdir -p $XDG_CONFIG_HOME/npm
mkdir -p $XDG_DATA_HOME/npm
mkdir -p $XDG_DATA_HOME/cargo
mkdir -p $XDG_DATA_HOME/rustup
mkdir -p $XDG_DATA_HOME/tig
mkdir -p $XDG_CACHE_HOME/zsh
mkdir -p $XDG_DATA_HOME/zsh
mkdir -p $XDG_DATA_HOME/tmux
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

echo "Almost Done! Just do that: https://blog.birkhoff.me/make-sudo-authenticate-with-touch-id-in-a-tmux/"
