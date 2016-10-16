#!/usr/bin/env bash
BASH_PATH=~/.bashrc;

if [ "$(uname)" == "Darwin" ]; then
  echo "Getting Things Ready for Mac:";
  BASH_PATH=~/.bash_profile;
fi

echo "Setting up in bash folder: $BASH_PATH"
echo '#syle bash' >> $BASH_PATH;
echo '. ~/.bash_syle' >> $BASH_PATH;

echo "Set up git stuffs"
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/.gitconfig >> ~/.gitconfig
