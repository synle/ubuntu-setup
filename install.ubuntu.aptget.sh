#!/usr/bin/env bash
is_os_ubuntu=0
apt-get -v &> /dev/null && is_os_ubuntu=1

function installAptGetModuleIfNeeded(){
    has_installed_app=0
    type $0 &> /dev/null && has_installed_app=1
    type $1 &> /dev/null && has_installed_app=1
    
    echo $0
    echo $1
    echo $2
    echo $3
    
    if [ $has_installed_app == "0" ]
    then
        echo "    INSTALL $0"
        sudo apt-get install -y --force-yes --fix-missing $0 &> /dev/null
    else
        echo "    SKIP    $0"
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
    installAptGetModuleIfNeeded openjdk-7-jdk java
    installAptGetModuleIfNeeded ant ant
    installAptGetModuleIfNeeded gradle gradle
    installAptGetModuleIfNeeded maven mvn
    
    # sudo apt-get install  -y --fix-missing mysql-client
    #
    # sudo apt-get install  -y --fix-missing python-dev
    # sudo apt-get install  -y --fix-missing python-software-properties
    # sudo apt-get install  -y --fix-missing software-properties-common
    # sudo apt-get install  -y --fix-missing gnuplot
fi
