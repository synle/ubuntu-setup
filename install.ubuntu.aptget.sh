#!/usr/bin/env bash
is_os_ubuntu=0
apt-get -v &> /dev/null && is_os_ubuntu=1

function installAptGetModuleIfNeeded(){
    has_installed_app=0
    type $@ &> /dev/null && has_installed_app=1
    
    echo "    INSTALL $@"
    
    if [ $has_installed_app == "0" ]
    then
        sudo apt-get install -y --force-yes --fix-missing $@ &> /dev/null
    fi
}


function installAptGetModuleIfNeededBackground(){
    has_installed_app=0
    type $@ &> /dev/null && has_installed_app=1
    
    echo "    INSTALL $@"
    
    if [ $has_installed_app == "0" ]
    then
        nohup sudo apt-get install -y --force-yes --fix-missing $@ &> /dev/null &
    fi
}

if [ $is_os_ubuntu == "1" ]
then
    # echo "  apt-get update..."
    # sudo apt-get update -y &> /dev/null

    echo "  apt-get install..."
    installAptGetModuleIfNeeded git
    installAptGetModuleIfNeeded vim
    installAptGetModuleIfNeeded curl
    installAptGetModuleIfNeeded tmux
    installAptGetModuleIfNeeded python
    installAptGetModuleIfNeeded tig
    installAptGetModuleIfNeeded unzip
    installAptGetModuleIfNeeded make
    installAptGetModuleIfNeeded jq
    installAptGetModuleIfNeeded figlet
    installAptGetModuleIfNeeded autoconf
    installAptGetModuleIfNeeded automake
    installAptGetModuleIfNeeded gcc
    installAptGetModuleIfNeeded g++
    installAptGetModuleIfNeeded build-essential
    installAptGetModuleIfNeeded unzip
    
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
