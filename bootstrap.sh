#!/usr/bin/env bash
set -e

if [[ ! -d "$HOME/Dropbox" ]]; then
    echo "Need to manually install Dropbox First and sync it."
    echo "Install XCode at the same time."
    exit 1
fi

echo "**************************************************************************"
echo "******************XCode tool Install...***********************************"
echo "**************************************************************************"
command -v gcc >/dev/null 2>&1 || { echo >&2 "I require gcc, i.e. XCode, but it's not installed.  Aborting."; exit 1; }
xcode-select --install

echo "**************************************************************************"
echo "******************Homebrew Install...*************************************"
echo "**************************************************************************"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "**************************************************************************"
echo "******************Application and tool installation...********************"
echo "**************************************************************************"
brew tap Homebrew/bundle
brew bundle --file=$HOME/Dropbox/Github/dotfiles/Brewfile

echo "**************************************************************************"
echo "*********************Change shell to zsh...*******************************"
echo "**************************************************************************"
chsh -s $(which zsh)

echo "**************************************************************************"
echo "*********************Install oh-my-zsh...*********************************"
echo "**************************************************************************"
git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
cd $HOME/.oh-my-zsh/custom/plugins
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
cd $HOME

echo "**************************************************************************"
echo "*********************Removing dotfiles...*********************************"
echo "**************************************************************************"
[ -f "$HOME/.bash_profile" ] && rm -f $HOME/.bash_profile
[ -d "$HOME/.config" ] && rm -rf $HOME/.config
[ -f "$HOME/.gitconfig" ] && rm -f $HOME/.gitconfig
[ -f "$HOME/.githelpers" ] && rm -f $HOME/.githelpers
[ -f "$HOME/.gitignore" ] && rm -f $HOME/.gitignore
[ -f "$HOME/.tmux.conf" ] && rm -f $HOME/.tmux.conf
[ -f "$HOME/.vimrc" ] && rm -f $HOME/.vimrc
[ -f "$HOME/.basic_vimrc" ] && rm -f $HOME/.basic_vimrc
[ -f "$HOME/.ideavimrc" ] && rm -f $HOME/.ideavimrc
[ -f "$HOME/.zshrc" ] && rm -f $HOME/.zshrc
[ -d "$HOME/.zsh" ] && rm -f $HOME/.zsh
[ -f "$HOME/.oh-my-zsh/themes/my_theme.zsh-theme" ] && rm -f $HOME/.oh-my-zsh/themes/my_theme.zsh-theme
[ -f "$HOME/.ackrc" ] && rm -f $HOME/.ackrc

echo "**************************************************************************"
echo "*********************Symlinking personal folders...***********************"
echo "**************************************************************************"
ln -s $HOME/Dropbox/Others/Pictures $HOME/Pictures/Pictures
ln -s $HOME/Dropbox/www $HOME/www
ln -s $HOME/Dropbox/Github/go/ $HOME/go

echo "**************************************************************************"
echo "*********************Symlinking dotfiles...*******************************"
echo "**************************************************************************"
mkdir $HOME/.config
ln -s $HOME/Dropbox/Github/dotfiles/bash_profile $HOME/.bash_profile
ln -s $HOME/Dropbox/Github/dotfiles/tmux $HOME/.tmux
ln -s $HOME/Dropbox/Github/dotfiles/gitconfig $HOME/.gitconfig
ln -s $HOME/Dropbox/Github/dotfiles/githelpers $HOME/.githelpers
ln -s $HOME/Dropbox/Github/dotfiles/gitignore $HOME/.gitignore
ln -s $HOME/Dropbox/Github/dotfiles/tmux.conf $HOME/.tmux.conf
ln -s $HOME/Dropbox/Github/dotfiles/vimrc $HOME/.vimrc
ln -s $HOME/Dropbox/Github/dotfiles/basic_vimrc $HOME/.basic_vimrc
ln -s $HOME/Dropbox/Github/dotfiles/ideavimrc $HOME/.ideavimrc
ln -s $HOME/Dropbox/Github/dotfiles/zshrc $HOME/.zshrc
ln -s $HOME/Dropbox/Github/dotfiles/zsh $HOME/.zsh
ln -s $HOME/Dropbox/Github/dotfiles/my_theme.zsh-theme $HOME/.oh-my-zsh/themes/my_theme.zsh-theme
ln -s $HOME/Dropbox/Github/dotfiles/ackrc $HOME/.ackrc

echo "**************************************************************************"
echo "************************Install Plug for vim...***************************"
echo "**************************************************************************"
mkdir -p $HOME/.vim/autoload
curl -fLo $HOME/.vim/autoload/plug.vim \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cd $HOME

echo "**************************************************************************"
echo "***********************Install Vim plugins...**************************"
echo "**************************************************************************"
vim -c "PlugInstall" -c q -c q

echo "**************************************************************************"
echo "************************Install Plug for nvim...***************************"
echo "**************************************************************************"
curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -s $HOME/Dropbox/Github/dotfiles/vimrc $HOME/.config/nvim/init.vim

echo "**************************************************************************"
echo "***********************Install nVim plugins...**************************"
echo "**************************************************************************"
nvim -c "PlugInstall" -c q -c q
nvim -c "UpdateRemotePlugins" -c q

echo "**************************************************************************"
echo "************************Install NVM***************************************"
echo "**************************************************************************"
git clone https://github.com/creationix/nvm.git $HOME/.nvm && cd $HOME/.nvm && git checkout `git describe --abbrev=0 --tags`
cd $HOME

echo "**************************************************************************"
echo "************************Install Node**************************************"
echo "**************************************************************************"
source $HOME/.zshrc
nvm install node

echo "Done!"
