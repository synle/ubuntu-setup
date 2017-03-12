#!/usr/bin/env bash
function installNvmNodeVersionIfNeeded(){
    echo "  Checking if we need to install node"
    echo "  ~/.nvm/versions/node/$@"
    [ -d "~/.nvm/versions/node/$@" ] || (echo "    nvm install $@" && nvm install $@ &> /dev/null)
}

echo "Install nvm, node. npm and stuffs"
[ -s ~/.nvm/nvm.sh ] || (echo "Install NVM" && curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash -)
. ~/.nvm/nvm.sh

echo "Install Nodes"
installNvmNodeVersionIfNeeded v0.12.15
installNvmNodeVersionIfNeeded v6.10.0

echo "Set up default nvm versions"
nvm alias default v0.12.15 &> /dev/null
nvm use default &> /dev/null

echo "Install npm@2.15.1"
npm i -g npm@2.15.1 &> /dev/null
