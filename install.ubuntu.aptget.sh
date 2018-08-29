#!/usr/bin/env bash

apt -v &> /dev/null && alias apt-get="apt"


echo 'apt-get update...'
sudo apt-get update -y &> /dev/null;

function installAptGetModuleIfNeeded(){
    echo "    $@"
    sudo apt-get install -y --force-yes --fix-missing $@ &> /dev/null
}

# start the installation...
echo 'apt-get install...'
installAptGetModuleIfNeeded git;
installAptGetModuleIfNeeded vim;
installAptGetModuleIfNeeded curl;
installAptGetModuleIfNeeded tmux;
installAptGetModuleIfNeeded python;
installAptGetModuleIfNeeded tig;
installAptGetModuleIfNeeded unzip;
installAptGetModuleIfNeeded make;
installAptGetModuleIfNeeded jq;
installAptGetModuleIfNeeded figlet;
installAptGetModuleIfNeeded autoconf;
installAptGetModuleIfNeeded automake;
installAptGetModuleIfNeeded gcc;
installAptGetModuleIfNeeded g++;
installAptGetModuleIfNeeded build-essential;
installAptGetModuleIfNeeded unzip;
installAptGetModuleIfNeeded openjdk-8-jdk;
installAptGetModuleIfNeeded ant;
installAptGetModuleIfNeeded gradle;
installAptGetModuleIfNeeded maven;
installAptGetModuleIfNeeded nginx;

# echo '''
# # Other Packages for GUI
# compizconfig-settings-manager
# '''
