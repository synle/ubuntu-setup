function installNodeModulesIfNeeded(){
    type $@ &> /dev/null || (echo "NPM Install $@" && npm i -g $@)
}

#resource nvm if needed
[ -s /opt/nvm/nvm.sh ] && . /opt/nvm/nvm.sh;
[ -s ~/.nvm/nvm.sh ] && . ~/.nvm/nvm.sh;

#download node npm deps
echo "Install Global Node Packages";
# npm i -g grunt-cli;
installNodeModulesIfNeeded grunt-init;
installNodeModulesIfNeeded bower;
installNodeModulesIfNeeded gulp;
installNodeModulesIfNeeded browserify;
installNodeModulesIfNeeded webpack;
installNodeModulesIfNeeded eslint;
installNodeModulesIfNeeded typings;
