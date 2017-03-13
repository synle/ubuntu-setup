#!/usr/bin/env bash
echo "   Vim & Vundle"
echo "      Vim Config .vimrc"
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/misc/vimrc > ~/.vimrc
echo "      Install Vundle"
[ -d ~/.vim/bundle/Vundle.vim ] \
    || git clone https://github.com/gmarik/Vundle.vim.git \
    ~/.vim/bundle/Vundle.vim &> /dev/null
vim +BundleInstall +qall &> /dev/null
