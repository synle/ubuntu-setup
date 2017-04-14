#!/usr/bin/env bash
NVM_BASE_PATH=~/.nvm

#resource nvm if needed
type nvm &> /dev/null || . "$NVM_BASE_PATH/nvm.sh"

function installNodeModulesIfNeeded(){
    for i; do 
        echo "    INSTALL $i"
    done

    nohup npm i -g $@ &> /dev/null &
}

#download node npm deps
echo "  npm i -g";
installNodeModulesIfNeeded grunt-init \
    bower \
    gulp \
    browserify \
    webpack \
    eslint \
    typings
    
