#!/usr/bin/env bash
function installNodeModulesIfNeeded(){
    type $@ &> /dev/null || (echo "npm i -g $@" && npm i -g $@)
}

#resource nvm if needed
[ -s ~/.nvm/nvm.sh ] && . ~/.nvm/nvm.sh;

#download node npm deps
echo "   Install Global Node Packages";
# npm i -g grunt-cli;
installNodeModulesIfNeeded grunt-init;
installNodeModulesIfNeeded bower;
installNodeModulesIfNeeded gulp;
installNodeModulesIfNeeded browserify;
installNodeModulesIfNeeded webpack;
installNodeModulesIfNeeded eslint;
installNodeModulesIfNeeded typings;
