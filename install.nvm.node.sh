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
[ -d $NVM_BASE_PATH ] || (echo "  git clone nvm" && curl -so- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash - )
[ -d $NVM_BASE_PATH ] && echo "  SKIP git clone nvm"
. "$NVM_BASE_PATH/nvm.sh"

echo "  nvm install"
installNvmNodeVersionIfNeeded v6.10.0


echo "  nvm default installation (v.0.12.15)"
if [ ! -d "$NVM_BASE_PATH/versions/node/v0.12.15" ]
then
    echo "     INSTALL node v.0.12.15"
    installNvmNodeVersionIfNeeded v0.12.15

    echo "       Setting nvm default"
    nvm alias default v0.12.15
    nvm use default

    echo "       Install npm@2.15.1"
    npm i -g npm@2.15.1
else
    echo "    SKIP"
fi
