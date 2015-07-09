#!/usr/bin/env bash

# install xcode
command -v gcc >/dev/null 2>&1 || { echo >&2 "I require gcc, i.e. XCode, but it's not installed.  Aborting."; exit 1; }
xcode-select --install

echo "Homebrew install"
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

echo "Application and tool installation"
brew bundle ~/Dropbox/Github/dotfiles/Brewfile

echo "Deleting the old files"
rm ~/.vimrc
rm ~/.ideavimrc
rm -r ~/.vim
rm ~/.bash_profile
rm ~/.gitignore
rm ~/.gitconfig
rm ~/.zshrc
rm -r ~/.zsh
rm -r ~/.oh-my-zsh
rm -r ~/.config/powerline
rm -r ~/.config/fish
rm -r ~/.oh-my-fish
rm ~/.tmux.conf
rm ~/.ackrc

echo "Symlinking files"
ln -s ~/Dropbox/Others/Pictures ~/Pictures
ln -s ~/Dropbox/www ~/www
ln -s ~/Dropbox/Github/dotfiles/vimrc ~/.vimrc
ln -s ~/Dropbox/Github/dotfiles/ideavimrc ~/.ideavimrc
ln -s ~/Dropbox/Github/dotfiles/vim ~/.vim
ln -s ~/Dropbox/Github/dotfiles/bash_profile ~/.bash_profile
ln -s ~/Dropbox/Github/dotfiles/gitignore ~/.gitignore
ln -s ~/Dropbox/Github/dotfiles/gitconfig ~/.gitconfig
ln -s ~/Dropbox/Github/dotfiles/zshrc ~/.zshrc
ln -s ~/Dropbox/Github/dotfiles/zsh ~/.zsh
ln -s ~/Dropbox/Github/dotfiles/oh-my-zsh ~/.oh-my-zsh
ln -s ~/Dropbox/Github/dotfiles/powerline ~/.config/powerline
ln -s ~/Dropbox/Github/dotfiles/fish ~/.config/fish
ln -s ~/Dropbox/Github/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/Dropbox/Github/dotfiles/oh-my-fish ~/.oh-my-fish
ln -s ~/Dropbox/Github/dotfiles/ackrc ~/.ackrc

echo "Installing python"
pip install --upgrade setuptools
pip install --upgrade pip
pip install virtualenv
pip install virtualenvwrapper
easy_install ipython[all]
easy_install ipython3[all]

echo "Installing plug for vim"
mkdir -p ~/.vim/autoload
curl -fLo ~/.vim/autoload/plug.vim \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Done!"

