#!/usr/bin/env bash

function installAptGetModuleIfNeeded(){
    echo "    INSTALL $@"
    sudo apt-get install -y --force-yes --fix-missing $@
}

# start the installation...
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
installAptGetModuleIfNeeded nginx ;

if [ -d "/mnt/c/Users" ]
  then
    echo "ignore optional deps for Windows Bash"
  else
    echo "install optionals deps for Ubuntu"
    installAptGetModuleIfNeeded linux-image-extra-$(uname -r);
    installAptGetModuleIfNeeded linux-image-extra-virtual;
    && echo "done optional deps..."
fi



# echo '''
# # Other Packages for GUI
# compizconfig-settings-manager
# '''
