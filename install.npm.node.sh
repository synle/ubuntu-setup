#!/usr/bin/env bash
NVM_BASE_PATH=~/.nvm

#resource nvm if needed
type nvm &> /dev/null || . "$NVM_BASE_PATH/nvm.sh"

function installNodeModulesIfNeeded(){
    type $@ &> /dev/null || (echo "    + $@" && npm i -g $@ &> /dev/null)
    type $@ &> /dev/null && echo "    - $@"
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
