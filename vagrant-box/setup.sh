# !/bin/bash

export PROVISION_USER=syle;
export HOME_SYLE=/home/$PROVISION_USER;
export BASH_PATH=$HOME_SYLE/.bashrc;

echo "Set Up User Credential"
sudo adduser --disabled-password --gecos "" $PROVISION_USER;
echo $PROVISION_USER:$PROVISION_USER | sudo chpasswd

echo "Set Up User Permissions: $PROVISION_USER"
sudo usermod -aG sudo $PROVISION_USER;
#sudo usermod -aG vboxsf $PROVISION_USER;
#sudo usermod -aG shadow $PROVISION_USER;


# echo "Make Virtualbox Window Bigger"
# echo "GRUB_GFXMODE=1152x864x32" >> /etc/default/grub
# sudo update-grub2


echo "Provisioning virtual machine...";
# sudo apt-get update -y;
sudo apt-get install -y curl git;


echo "Setting up github stuffs for syle"
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/vagrant-box/.gitconfig \
    > $HOME_SYLE/.gitconfig



echo "Install nvm for syle"
export NVM_DIR="$HOME_SYLE/.nvm" && (
  git clone https://github.com/creationix/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
) && . "$NVM_DIR/nvm.sh"

echo "Set up nvm for Sy Le"
echo '#nvm (node version manager)' >> $BASH_PATH
echo 'export NVM_DIR="'$HOME_SYLE'/.nvm"' >> $BASH_PATH
echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" #' >> $BASH_PATH


#source the bash profile
echo "Setting up in bash folder: $BASH_PATH"
echo '#syle bash' >> $BASH_PATH;
echo '[ -s ~/.bash_syle ] && . ~/.bash_syle' >> $BASH_PATH;


echo "Install node@v0.12.15 - stable - iojs";
nvm install v0.12.15;
nvm install stable;
nvm install iojs;
nvm alias default v0.12.15;

echo "Install npm@2.15.1";
npm install npm@2.15.1 -g;

#download node npm deps
echo "Install Global Node Packages";
npm i -g \
    grunt-cli \
    grunt-init \
    bower \
    gulp \
    browserify \
    webpack \
    eslint \
    typings;



echo "make syle:syle owner"
sudo chown -R syle:syle $HOME_SYLE


sudo apt-get install vim;

# sudo apt-get install  -y \
#     --fix-missing \
#     git \
#     vim \
#     g++ \
#     unzip \
#     openjdk-7-jdk \
#     ant \
#     gradle \
#     maven \
#     curl \
#     tmux;
