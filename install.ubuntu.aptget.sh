#!/usr/bin/env bash
is_os_ubuntu=0
apt-get -v &> /dev/null && is_os_ubuntu=1

function installAptGetModuleIfNeeded(){
    for i; do 
        echo "    INSTALL FG $i"
    done
    sudo apt-get install -y --force-yes --fix-missing $@ >> /tmp/debug
}

if [ $is_os_ubuntu == "1" ]
then
    # echo "  apt-get update..."
    # sudo apt-get update -y  >> /tmp/debug

    echo "  apt-get install..."
    #     must have
    installAptGetModuleIfNeeded git \
        vim \
        curl \
        tmux \
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
        openjdk-8-jdk \
        ant \
        gradle \
        maven
fi
