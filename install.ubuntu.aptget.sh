#!/usr/bin/env bash

function installAptGetModuleIfNeeded(){
    for i; do 
        echo "    INSTALL $i"
    done
    sudo apt-get install -y --force-yes --fix-missing $@
}

# start the installation...
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
    maven \
    nginx \
    php7.0-cli \
    php7.0-fpm \
    php7.0-common \
    apt-transport-https \
    ca-certificates \
    software-properties-common  \
    && echo "done core deps..."
    
    
installAptGetModuleIfNeeded linux-image-extra-$(uname -r) \
    linux-image-extra-virtual \
    software-properties-common  \
    && echo "done optional deps..."


echo '''
# Other Packages for GUI
compizconfig-settings-manager
'''
