#!/usr/bin/env bash
BASH_PATH=~/.bashrc;
NVM_DIR=~/.nvm

#is ubuntu
is_ubuntu=0
apt-get -v &> /dev/null && is_ubuntu=1
if [ $is_ubuntu == "1" ]; then
  echo "Ubuntu Environment...";
  curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.ubuntu.aptget.sh | bash -
fi
if [ "$(uname)" == "Darwin" ]; then
  BASH_PATH=~/.bash_profile;
  curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.mac.darwin.sh | bash -
fi


#source the bash profile
echo "Install nvm@v0.33.0"
echo "#nvm (node version manager)" >> $BASH_PATH
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | NVM_DIR=$NVM_DIR bash
#echo "[ -s $NVM_DIR/nvm.sh ] && . $NVM_DIR/nvm.sh" | tee -a $BASH_PATH;

echo "Re-source Bash Profile for nvm binary"
. ${BASH_PATH}

echo "Install nvm, node. npm and stuffs"
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.nvm.node.sh | bash -


echo "Setting up in bash folder: $BASH_PATH"
grep -q -F '.bash_syle' $BASH_PATH || echo """
#syle bash
[ -s ~/.bash_syle ] && . ~/.bash_syle
""" >> $BASH_PATH

echo "refresh"
curl -H 'Cache-Control: no-cache' -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/makeBashRefresh.sh | bash -

