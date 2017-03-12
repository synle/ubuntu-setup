#!/usr/bin/env bash
is_os_darwin_mac=0
[ -d /Library ] && is_os_darwin_mac=1

#################################
# script begins....
# refresh script starts here...
#################################

function installMacAppIfNotThereAlready(){
    type $@ &> /dev/null || (echo "  brew install $@" && brew install $@);
    type $@ &> /dev/null && echo "  SKIPPED brew install $@"
}

if [ $is_os_darwin_mac == "1" ]
then
    echo "Install Homebrew"
    hasHomebrewInstalled=1
    type brew &> /dev/null || hasHomebrewInstalled=0
    
    if [ $hasHomebrewInstalled == "0" ]
    then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        echo "Brew install stuffs"
        brew tap homebrew/dupes
        brew tap homebrew/versions
        brew tap homebrew/homebrew-php
        #     brew unlink php56
        brew install php70;
    fi
    installMacAppIfNotThereAlready jq;
    installMacAppIfNotThereAlready fzf;
    installMacAppIfNotThereAlready tig;
fi
