#!/usr/bin/env bash
NVM_BASE_PATH=~/.nvm

function installNvmNodeVersionIfNeeded(){
    if [ ! -d "$NVM_BASE_PATH/versions/node/$@" ]
    then
        echo "  nvm install $@"
        nvm install $@ &> /dev/null
    fi
}

echo "  Install nvm"
[ -d $NVM_BASE_PATH ] || (echo "Install NVM" && curl -so- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash -  &> /dev/null)
type nvm &> /dev/null || . "$NVM_BASE_PATH/nvm.sh"

echo "  Install Nodes"
installNvmNodeVersionIfNeeded v6.10.0

if [ ! -d "$NVM_BASE_PATH/versions/node/v0.12.15" ]
then
    echo "     Install node v.0.12.15"
    installNvmNodeVersionIfNeeded v0.12.15

    echo "       Setting nvm default"
    nvm alias default v0.12.15 &> /dev/null
    nvm use default &> /dev/null

    echo "       Install npm@2.15.1"
    npm i -g npm@2.15.1 &> /dev/null
fi
