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
installAptGetModuleIfNeeded openjdk-8-jdk;
installAptGetModuleIfNeeded ant;
installAptGetModuleIfNeeded gradle;
installAptGetModuleIfNeeded maven;
installAptGetModuleIfNeeded nginx;
installAptGetModuleIfNeeded dialog;
installAptGetModuleIfNeeded xclip

# echo '''
# # Other Packages for GUI
# compizconfig-settings-manager
# '''

# remove these ones...
sudo apt-get remove abiword* \
  audacious* \
  galculator \
  gnome-mpv* \
  gnumeric* \
  leafpad \
  pidgin* \
  simple-scan* \
  sylpheed* \
  transmission-* \
  xfburn* \
  xpad* \
  guvcview* \
  mtpaint* \
  evince* \
  && echo '  Done Remove Packages'

# firefox* \
# pulseaudio* \


# non traditional (not in apt-get)
pushd /tmp
wget https://github.com/sharkdp/bat/releases/download/v0.6.0/bat_0.6.0_amd64.deb
sudo dpkg -i bat-*.deb &> /dev/null
popd
