#!/usr/bin/env bash
set -e

DOTFILES_HOME=$HOME/.dotfiles

echo "**************************************************************************"
echo "******************Command line tooling install...***********************************"
echo "**************************************************************************"
# TODO find how to install tooling without having to install XCode
command -v gcc >/dev/null 2>&1 && xcode-select --install || true
command -v gcc >/dev/null 2>&1 || { echo >&2 "I require gcc, i.e. XCode, but it's not installed.  Aborting."; exit 1; }

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

echo "**************************************************************************"
echo "******************Application and tool installation...********************"
echo "**************************************************************************"
brew tap Homebrew/bundle
brew bundle --file=$DOTFILES_HOME/Brewfile

echo "**************************************************************************"
echo "*********************Removing dotfiles...*********************************"
echo "**************************************************************************"
[ -d "$HOME/.config" ] && rm -rf $HOME/.config
[ -d "$HOME/.oh-my-zsh" ] && rm -rf $HOME/.oh-my-zsh
[ -d "$HOME/.tmux" ] && rm -rf $HOME/.tmux
[ -d "$HOME/.zsh" ] && rm -rf $HOME/.zsh
[ -f "$HOME/.ackrc" ] && rm -f $HOME/.ackrc
[ -f "$HOME/.bash_profile" ] && rm -f $HOME/.bash_profile
[ -f "$HOME/.gitconfig" ] && rm -f $HOME/.gitconfig
[ -f "$HOME/.gitignore" ] && rm -f $HOME/.gitignore
[ -f "$HOME/.ideavimrc" ] && rm -f $HOME/.ideavimrc
[ -f "$HOME/.tmux.conf" ] && rm -f $HOME/.tmux.conf
[ -f "$HOME/.vimrc" ] && rm -f $HOME/.vimrc
[ -f "$HOME/.zshrc" ] && rm -f $HOME/.zshrc
[ -f "$HOME/Documents/mysolarized.itermcolors" ] && rm -f $HOME/Documents/mysolarized.itermcolors

echo "**************************************************************************"
echo "*********************Install oh-my-zsh...*********************************"
echo "**************************************************************************"
git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh && git clone git://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

echo "**************************************************************************"
echo "************************Install Plug for nvim...***************************"
echo "**************************************************************************"
sudo pip install --upgrade neovim
sudo pip3 install --upgrade neovim
curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "**************************************************************************"
echo "*********************Symlinking dotfiles...*******************************"
echo "**************************************************************************"
ln -s $DOTFILES_HOME/ackrc $HOME/.ackrc
ln -s $DOTFILES_HOME/bash_profile $HOME/.bash_profile
ln -s $DOTFILES_HOME/basic_vimrc $HOME/.vimrc
ln -s $DOTFILES_HOME/gitignore $HOME/.gitignore
ln -s $DOTFILES_HOME/ideavimrc $HOME/.ideavimrc
ln -s $DOTFILES_HOME/my_theme.zsh-theme $HOME/.oh-my-zsh/themes/my_theme.zsh-theme
ln -s $DOTFILES_HOME/mysolarized.itermcolors $HOME/Documents/mysolarized.itermcolors
ln -s $DOTFILES_HOME/tmux $HOME/.tmux
ln -s $DOTFILES_HOME/tmux.conf $HOME/.tmux.conf
ln -s $DOTFILES_HOME/vim/snips $HOME/.config/nvim/snips
ln -s $DOTFILES_HOME/vimrc $HOME/.config/nvim/init.vim
ln -s $DOTFILES_HOME/zsh $HOME/.zsh
ln -s $DOTFILES_HOME/zshrc $HOME/.zshrc

echo "**************************************************************************"
echo "***********************Install nVim plugins...**************************"
echo "**************************************************************************"
nvim -c "PlugInstall" -c q -c q
nvim -c "UpdateRemotePlugins" -c q

echo "**************************************************************************"
echo "******************Dropbox Install...**************************************"
echo "**************************************************************************"
if [[ ! -d "$HOME/Dropbox" ]]; then
    echo "Need to sync Dropbox"
    exit 1
fi

echo "**************************************************************************"
echo "*********************Symlinking personal folders...***********************"
echo "**************************************************************************"
ln -s $HOME/Dropbox/_Concordia $HOME/concordia
ln -s $HOME/Dropbox/Github/go $HOME/go

echo "**************************************************************************"
echo "*********************Change shell to zsh...*******************************"
echo "**************************************************************************"
command -v zsh | sudo tee -a /etc/shells
sudo chsh -s "$(command -v zsh)" "${USER}"

echo "**************************************************************************"
echo "*********************Gems install...**************************************"
echo "**************************************************************************"
sudo gem install coderay
sudo gem install tmuxinator

echo "**************************************************************************"
echo "*********************Hammerspoon install...*******************************"
echo "**************************************************************************"
mkdir -p $HOME/.hammerspoon/Spoons
git clone https://github.com/jasonrudolph/ControlEscape.spoon.git $HOME/.hammerspoon/Spoons/ControlEscape.spoon
cd $HOME/.hammerspoon/Spoons/ControlEscape.spoon
script/setup
script/remap-caps-lock-to-control

echo "**************************************************************************"
echo "*********************Global node packages...******************************"
echo "**************************************************************************"
npm install -g tern
npm install -g standard

echo "Done!"
