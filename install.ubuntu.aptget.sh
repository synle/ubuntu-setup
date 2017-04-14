#!/usr/bin/env bash
is_os_ubuntu=0
apt-get -v &> /dev/null && is_os_ubuntu=1

function installAptGetModuleIfNeeded(){
    sudo apt-get install -y --force-yes --fix-missing $@ &> /dev/null
}


function installAptGetModuleIfNeededBackground(){
    sudo -b apt-get install -y --force-yes --fix-missing $@ &> /dev/null
}

if [ $is_os_ubuntu == "1" ]
then
    # echo "  apt-get update..."
    # sudo apt-get update -y &> /dev/null

    echo "  apt-get install..."
    installAptGetModuleIfNeeded git
    installAptGetModuleIfNeeded vim
    installAptGetModuleIfNeeded curl
    installAptGetModuleIfNeededBackground tmux
    installAptGetModuleIfNeededBackground python
    installAptGetModuleIfNeededBackground tig
    installAptGetModuleIfNeededBackground unzip
    installAptGetModuleIfNeededBackground make
    installAptGetModuleIfNeededBackground jq
    installAptGetModuleIfNeededBackground figlet
    installAptGetModuleIfNeededBackground autoconf
    installAptGetModuleIfNeededBackground automake
    installAptGetModuleIfNeededBackground gcc
    installAptGetModuleIfNeededBackground g++
    installAptGetModuleIfNeededBackground build-essential
    installAptGetModuleIfNeededBackground unzip
    
    # java stuffs
    installAptGetModuleIfNeededBackground openjdk-7-jdk
    installAptGetModuleIfNeededBackground ant
    installAptGetModuleIfNeededBackground gradle
    installAptGetModuleIfNeededBackground maven
    
    # sudo apt-get install  -y --fix-missing mysql-client
    #
    # sudo apt-get install  -y --fix-missing python-dev
    # sudo apt-get install  -y --fix-missing python-software-properties
    # sudo apt-get install  -y --fix-missing software-properties-common
    # sudo apt-get install  -y --fix-missing gnuplot
fi
