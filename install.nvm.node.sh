#!/usr/bin/env bash
NVM_BASE_PATH=~/.nvm

function installNvmNodeVersionIfNeeded(){
    if [ ! -d "$NVM_BASE_PATH/versions/node/$@" ]
    then
        echo "    INSTALL $@"
        nvm install $@
    else
        echo "    SKIP    $@"
    fi
}

#install nvm itself.
[ -d $NVM_BASE_PATH ] || (echo "  git clone nvm" && curl -so- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash - )
[ -d $NVM_BASE_PATH ] && echo "  SKIP git clone nvm"
. "$NVM_BASE_PATH/nvm.sh"

echo "  nvm install"
installNvmNodeVersionIfNeeded v7.6
nvm alias default v7.6
nvm use default
