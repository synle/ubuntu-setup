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
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/vim/.vimrc >> $HOME_SYLE/.vimrc


#set up git
echo "Set up bash_profile"
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/makeBashInstall.sh | bash
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/makeBashRefresh.sh | bash

echo "# color styles for ls" >> $RC_SYLE;
echo "LS_COLORS='rs=0:di=01;36:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'" >> $RC_SYLE;
echo "export LS_COLORS" >> $RC_SYLE;

echo "Setting up github stuffs for syle"
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/vagrant-box/.gitconfig > $HOME_SYLE/.gitconfig

echo "Make Virtualbox Window Bigger"
echo "GRUB_GFXMODE=1152x864x32" >> /etc/default/grub
sudo update-grub2



### custom programs start here


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
npm install -g grunt-cli bower gulp browserify webpack eslint;

# echo "Install docker"
# sudo apt-get install apt-transport-https ca-certificates
# sudo echo "deb https://apt.dockerproject.org/repo ubuntu-precise main" > /etc/apt/sources.list.d/docker.list
# sudo apt-get update
# sudo apt-get purge lxc-docker
# apt-cache policy docker-engine
# sudo apt-get install -y linux-image-extra-3.2.0-23-virtual apparmor  linux-image-generic-lts-trusty docker-engine
# docker run hello-world


# bash color hack
# http://serverfault.com/questions/137649/changing-terminal-colors-in-ubuntu-server
