#!/usr/bin/env bash
NVM_DIR=~/.nvm;
BASH_PATH=~/.bashrc;
[ -s ~/.bash_profile ] && BASH_PATH=~/.bash_profile

#is ubuntu
is_ubuntu=0
apt-get -v &> /dev/null && is_ubuntu=1
if [ $is_ubuntu == "1" ]; then
  echo "Ubuntu Environment...";
  curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.ubuntu.aptget.sh | bash -
fi
if [ "$(uname)" == "Darwin" ]; then
  echo "Setting up for Mac OSX"
  curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.mac.darwin.sh | bash -
fi


#source the bash profile
echo "Install nvm@v0.33.0 if needed"
[ -s $NVM_DIR/nvm.sh ] || curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | NVM_DIR=$NVM_DIR bash

echo "Re-source Bash Profile for nvm binary"
. ${BASH_PATH}

echo "Install nvm, node. npm and stuffs"
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.nvm.node.sh | bash -

echo "refresh"
curl -H 'Cache-Control: no-cache' -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/makeBashRefresh.sh | bash -

