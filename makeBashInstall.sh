#!/usr/bin/env bash
BASH_PATH=~/.bashrc;

if [ "$(uname)" == "Darwin" ]; then
  echo "Doing Mac Specific Setup:";
  BASH_PATH=~/.bash_profile;
  brew install fzf jq;
fi

# else 
# fzf
# git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
# ~/.fzf/install


echo "Setting up in bash folder: $BASH_PATH"
echo '#syle bash' >> $BASH_PATH;
echo '. ~/.bash_syle' >> $BASH_PATH;


echo "Set up git stuffs"
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/.gitconfig >> ~/.gitconfig
