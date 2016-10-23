# !/bin/bash

export PROVISION_USER=syle;
export HOME_SYLE=/home/$PROVISION_USER;

echo "Set Up User Credential"
sudo adduser --disabled-password --gecos "" $PROVISION_USER;
echo $PROVISION_USER:$PROVISION_USER | sudo chpasswd

echo "Set Up User Permissions: $PROVISION_USER"
sudo usermod -aG sudo $PROVISION_USER;
#sudo usermod -aG vboxsf $PROVISION_USER;
#sudo usermod -aG shadow $PROVISION_USER;


echo "Make Virtualbox Window Bigger"
echo "GRUB_GFXMODE=1152x864x32" >> /etc/default/grub
sudo update-grub2


echo "Provisioning virtual machine...";
sudo apt-get install -y curl git;
# sudo apt-get install  -y \
#     curl \
#     git \
#     build-essential \
#     openjdk-7-jdk \
#     python-dev \
#     python-software-properties \
#     software-properties-common \
#     g++ \
#     python \
#     supervisor \
#     automake \
#     gnuplot \
#     unzip \
#     vim \
#     ant \
#     gradle \
#     maven \
#     make \
#     mysql-client;\


echo "Setting up github stuffs for syle"
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/vagrant-box/.gitconfig > $HOME_SYLE/.gitconfig

#set up git
# echo "Set up bash_profile"
# curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/makeBashInstall.sh | bash;
# curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/makeBashRefresh.sh | bash

# bash color hack
# http://serverfault.com/questions/137649/changing-terminal-colors-in-ubuntu-server



