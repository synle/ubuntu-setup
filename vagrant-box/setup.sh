#!/bin/bash
export PROVISION_USER=syle;
export HOME_SYLE=/home/$PROVISION_USER;
export BASH_SYLE=$HOME_SYLE/.bash_syle;
export RC_SYLE=$HOME_SYLE/.bashrc;
export NVM_SCRIPT_PATH=/etc/profile.d/nvm.sh; #nvm path
export TEMP_BASH_SYLE=/tmp/.bash_syle

#
# echo "Install Guest Addition"
# mount /dev/cdrom /mnt
# cd /mnt
# ./VBoxLinuxAdditions.run

echo "Install External Repo";
echo "Install mongodb";
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10;
sudo add-apt-repository ppa:chris-lea/redis-server;

echo "Install redis";
echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list;


echo "Update Apt-get";
sudo apt-get -y update;

echo "Provisioning virtual machine...";
sudo apt-get install -y jq curl build-essential unzip git make python vim tmux mysql-client openjdk-7-jdk maven gradle;
sudo apt-get install -y mongodb-org redis-server;

echo "Set Up User Credential"
sudo adduser --disabled-password --gecos "" $PROVISION_USER;
echo $PROVISION_USER:$PROVISION_USER | sudo chpasswd

echo "Set Up User Permissions"
sudo usermod -aG sudo $PROVISION_USER;
#sudo usermod -aG vboxsf $PROVISION_USER;
#sudo usermod -aG shadow $PROVISION_USER;

echo "Install Vim Config and Bundle (VUNDLE)";
git clone https://github.com/VundleVim/Vundle.vim.git $HOME_SYLE/.vim/bundle/Vundle.vim;
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/.vimrc >> $HOME_SYLE/.vimrc

echo "Install Node Version Manager (NVM)";
git clone https://github.com/creationix/nvm.git /opt/nvm;
mkdir /usr/local/nvm /usr/local/node;
sudo chown syle:syle -R /usr/local/nvm/ /usr/local/node/ /home/syle;

echo "Set up NVM for all users";
touch $NVM_SCRIPT_PATH;
sudo chmod 755 $NVM_SCRIPT_PATH;
echo 'export NVM_DIR=/usr/local/nvm' >> $NVM_SCRIPT_PATH;
echo 'export PATH=/usr/local/node/bin:$PATH' >> $NVM_SCRIPT_PATH;
echo 'source /opt/nvm/nvm.sh' >> $NVM_SCRIPT_PATH;



echo "Install Node Stable and ioJS";
. $NVM_SCRIPT_PATH
nvm install stable;
nvm install iojs;
nvm alias default stable;
npm install -g grunt-cli grunt-init bower gulp browserify webpack eslint;


echo "Set up bash_profile"
echo "#syle script" >> $RC_SYLE;
echo $NVM_SCRIPT_PATH >> $RC_SYLE;
echo '. ~/.bash_syle' >> $RC_SYLE;
echo 'Setting up in ' + $TEMP_BASH_SYLE
  #completion
  curl -so- https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash >> $TEMP_BASH_SYLE
  curl -so- https://raw.githubusercontent.com/gruntjs/grunt-cli/master/completion/bash >> $TEMP_BASH_SYLE
  curl -so- https://raw.githubusercontent.com/gulpjs/gulp/master/completion/bash >> $TEMP_BASH_SYLE
  eval "$(grunt --completion=bash)" >> $TEMP_BASH_SYLE

  #prompt
  curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-prompt.sh >> $TEMP_BASH_SYLE

  #alias
  curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-alias-cmd.sh >> $TEMP_BASH_SYLE


mv $TEMP_BASH_SYLE $BASH_SYLE


echo "Setting up github stuffs for syle"
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/vagrant-box/.gitconfig >> $HOME_SYLE/.gitconfig


# echo "Install docker"
sudo apt-get install apt-transport-https ca-certificates
sudo echo "deb https://apt.dockerproject.org/repo ubuntu-precise main" > /etc/apt/sources.list.d/docker.list
sudo apt-get update
sudo apt-get purge lxc-docker
apt-cache policy docker-engine
sudo apt-get install -y linux-image-extra-3.2.0-23-virtual apparmor  linux-image-generic-lts-trusty docker-engine
docker run hello-world