#!/usr/bin/env bash
BASH_PATH=~/.bashrc;

#is ubuntu
is_ubuntu=0
apt-get -v &> /dev/null && is_ubuntu=1
if [ $is_ubuntu == "1" ]; then
#   echo "Ubuntu apt-get update...";
#   sudo apt-get update -y;  
  
  echo "Ubuntu apt-get install...";
  sudo apt-get install  -y \
    --fix-missing \
    git \
    g++ \
    unzip \
    vim \
    make \
    mysql-client \
    openjdk-7-jdk \
    ant \
    gradle \
    maven \
    # build-essential \
    # python \
    # python-dev \
    # python-software-properties \
    # software-properties-common \
    # supervisor \
    # automake \
    # gnuplot \
    curl;
fi
if [ "$(uname)" == "Darwin" ]; then
  BASH_PATH=~/.bash_profile;
  
  echo "Install Homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  
  echo "Brew install stuffs"
  brew install jq fzf;
fi


#source the bash profile
echo "Setting up in bash folder: $BASH_PATH"
echo '#syle bash' >> $BASH_PATH;
echo '. ~/.bash_syle' >> $BASH_PATH;

echo "Install nvm@v0.32.0"
curl -so- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash

echo "Re-source Bash Profile for nvm binary"
. ${BASH_PATH}

echo "Install node@v0.12.15";
nvm install v0.12.15;
nvm alias default v0.12.15;
 
echo "Install npm@2.15.1";
npm install npm@2.15.1 -g;

#download node npm deps
echo "Install Global Node Packages";
npm i -g  grunt-cli grunt-init bower gulp browserify webpack eslint typings;


echo "Run the initial refresh script"
. ${BASH_PATH}
curl -H 'Cache-Control: no-cache' -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/makeBashRefresh.sh | bash

