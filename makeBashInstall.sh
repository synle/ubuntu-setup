#!/usr/bin/env bash
BASH_PATH=~/.bashrc;

if [ "$(uname)" == "Darwin" ]; then
  echo "Doing Mac Specific Setup:";
  BASH_PATH=~/.bash_profile;
  curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/mac/mac.setup.sh | bash -;
fi

echo "Setting up in bash folder: $BASH_PATH"
echo '#syle bash' >> $BASH_PATH;
echo '. ~/.bash_syle' >> $BASH_PATH;


echo "Set up git stuffs"
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/vagrant-box/.gitconfig >> ~/.gitconfig


echo "Set up vim"
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim;
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/vim/.vimrc > ~/.vimrc;
vim +BundleInstall +qall
