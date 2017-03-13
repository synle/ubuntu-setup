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
    #################################
    # homebrew install
    #################################
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
    
    
    
    #################################
    # OSX Defaults
    #################################
    echo "  OSX Defaults"
    #show all hidden files
    #defaults write com.apple.finder AppleShowAllFiles YES;

    #http://apple.stackexchange.com/questions/14001/how-to-turn-off-all-animations-on-os-x
    # opening and closing windows and popovers
    defaults write -g NSAutomaticWindowAnimationsEnabled -bool false;

    # smooth scrolling
    defaults write -g NSScrollAnimationEnabled -bool false;

    # showing and hiding sheets, resizing preference windows, zooming windows
    # float 0 doesn't work
    defaults write -g NSWindowResizeTime -float 0.001;

    # opening and closing Quick Look windows
    defaults write -g QLPanelAnimationDuration -float 0;

    # rubberband scrolling (doesn't affect web views)
    defaults write -g NSScrollViewRubberbanding -bool false;

    # resizing windows before and after showing the version browser
    # also disabled by NSWindowResizeTime -float 0.001
    defaults write -g NSDocumentRevisionsWindowTransformAnimation -bool false;

    # showing a toolbar or menu bar in full screen
    defaults write -g NSToolbarFullScreenAnimationDuration -float 0;

    # scrolling column views
    defaults write -g NSBrowserColumnAnimationSpeedMultiplier -float 0;

    # showing and hiding Launchpad
    defaults write com.apple.dock springboard-show-duration -float 0;
    defaults write com.apple.dock springboard-hide-duration -float 0;

    # at least AnimateInfoPanes
    defaults write com.apple.finder DisableAllAnimations -bool true;

    # sending messages and opening windows for replies
    defaults write com.apple.Mail DisableSendAnimations -bool true;
    defaults write com.apple.Mail DisableReplyAnimations -bool true;




    #############################################################################
    # changing pages in Launchpad
    defaults write com.apple.dock springboard-page-duration -float 0;


    # showing and hiding Mission Control, command+numbers
    defaults write com.apple.dock expose-animation-duration -float 0;

    # showing the Dock
    defaults write com.apple.dock autohide-time-modifier -float 0;
    defaults write com.apple.dock autohide-delay -float 0;


    #screenshot folder
    mkdir -p ~/Desktop/_screenshots
    defaults write com.apple.screencapture location ~/Desktop/_screenshots;
fi
