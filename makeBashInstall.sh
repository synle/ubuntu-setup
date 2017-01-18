#!/usr/bin/env bash
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


echo "Install nvm if needed (idempotent)"
[ -s ~/.nvm/nvm.sh ] || curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash -

echo "Install nvm, node. npm and stuffs"
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.nvm.node.sh | bash -

echo "Refresh (idempotent)"
curl -H 'Cache-Control: no-cache' -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/makeBashRefresh.sh | bash -

