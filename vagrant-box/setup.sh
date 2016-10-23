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
sudo apt-get update -y;
sudo apt-get install  -y \
    --fix-missing \
    git \
    curl;


echo "Setting up github stuffs for syle"
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/vagrant-box/.gitconfig \
    > $HOME_SYLE/.gitconfig
    
    

echo "Install nvm for syle"
export NVM_DIR="$HOME_SYLE/.nvm" && (
  git clone https://github.com/creationix/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
) && . "$NVM_DIR/nvm.sh"

echo "Set up nvm for Sy Le"
echo '#nvm (node version manager)' >> $HOME_SYLE
echo 'export NVM_DIR="'$HOME_SYLE'/.nvm"' >> $HOME_SYLE
echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" #' >> $HOME_SYLE


echo "Install nodes"
nvm install v0.12.15;
nvm install stable;
nvm install iojs;
nvm alias default v0.12.15;


npm i -g \
    grunt-cli \
    grunt-init \
    bower \
    gulp \
    browserify \
    webpack \
    eslint \
    typings;



# bash color hack
# http://serverfault.com/questions/137649/changing-terminal-colors-in-ubuntu-server





sudo apt-get install  -y \
    --fix-missing \
    g++ \
    unzip \
    vim \
    make \
    mysql-client \
    openjdk-7-jdk \
    ant \
    gradle \
    maven;
