#!/usr/bin/env bash
is_os_darwin_mac=0
[ -d /Library ] && is_os_darwin_mac=1

#################################
# script begins....
# refresh script starts here...
#################################

function installMacAppIfNotThereAlready(){
    type $@ &> /dev/null || (echo "    INSTALL $@" && brew install $@);
    type $@ &> /dev/null && (echo "    SKIP    $@")
}

if [ $is_os_darwin_mac == "1" ]
then
    echo "setting up homebrew"
    hasHomebrewInstalled=1
    type brew &> /dev/null || hasHomebrewInstalled=0
    type brew &> /dev/null && echo "  SKIP homebrew"
    
    if [ $hasHomebrewInstalled == "0" ]
    then
        echo "  INSTALL homebrew"
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        
        echo "  brew tap"
        brew tap homebrew/dupes
        brew tap homebrew/versions
        brew tap homebrew/homebrew-php
        #     brew unlink php56
        #     brew install php70;
    fi
    
    echo "  brew install"
    installMacAppIfNotThereAlready jq;
    installMacAppIfNotThereAlready fzf;
    installMacAppIfNotThereAlready tig;
fi
