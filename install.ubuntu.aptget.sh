#!/usr/bin/env bash
is_os_ubuntu=0
apt-get -v &> /dev/null && is_os_ubuntu=1

function installAptGetModuleIfNeeded(){
    for i; do 
        echo "    INSTALL $i"
    done
    sudo apt-get install -y --force-yes --fix-missing $@ &> /dev/null
}


function installAptGetModuleIfNeededBackground(){
    for i; do 
        echo "    INSTALL $i"
    done
    sudo -b apt-get install -y --force-yes --fix-missing $@ &> /dev/null
}

if [ $is_os_ubuntu == "1" ]
then
    # echo "  apt-get update..."
    # sudo apt-get update -y &> /dev/null

    echo "  apt-get install..."
    #     must have
    installAptGetModuleIfNeeded git \
    vim \
    curl
    
    
    #     async can be done in background
    installAptGetModuleIfNeededBackground tmux \
        python \
        tig \
        unzip \
        make \
        jq \
        figlet \
        autoconf \
        automake \
        gcc \
        g++ \
        build-essential \
        unzip \
        openjdk-7-jdk \
        ant \
        gradle \
        maven
    
    # sudo apt-get install  -y --fix-missing mysql-client
    #
    # sudo apt-get install  -y --fix-missing python-dev
    # sudo apt-get install  -y --fix-missing python-software-properties
    # sudo apt-get install  -y --fix-missing software-properties-common
    # sudo apt-get install  -y --fix-missing gnuplot
fi
