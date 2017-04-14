#!/usr/bin/env bash
NVM_BASE_PATH=~/.nvm

#resource nvm if needed
type nvm &> /dev/null || . "$NVM_BASE_PATH/nvm.sh"

function installNodeModulesIfNeeded(){
    echo "    INSTALL $@"
    nohup npm i -g $@ &> /dev/null &
}

#download node npm deps
echo "  npm i -g";
# npm i -g grunt-cli;
installNodeModulesIfNeeded grunt-init;
installNodeModulesIfNeeded bower;
installNodeModulesIfNeeded gulp;
installNodeModulesIfNeeded browserify;
installNodeModulesIfNeeded webpack;
installNodeModulesIfNeeded eslint;
installNodeModulesIfNeeded typings;
