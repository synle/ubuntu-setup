# sudo adduser syle
# sudo usermod -a -G sudo,adm syle

#bare minimum
	sudo addgroup hadoop
	sudo adduser --ingroup hadoop hduser
	sudo apt-get install -y git

	git config --global user.email "lenguyensy+vm@gmail.com"
	git config --global user.name "syle_vm"
	git config --global core.autocrlf true
	git config --global color.ui auto
	git config --global color.diff true
	git config --global core.editor "vim"


#download stuffs
	wget https://launchpad.net/~fish-shell/+archive/ubuntu/release-2/+build/7644652/+files/fish-dbg_2.2.0-1~wily_amd64.deb -O /tmp
	wget http://download.netbeans.org/netbeans/8.1/final/bundles/netbeans-8.1-linux.sh -O /tmp
	wget http://mirror.cc.columbia.edu/pub/software/eclipse/technology/epp/downloads/release/mars/1/eclipse-jee-mars-1-win32-x86_64.zip -O /tmp
	wget http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3083_amd64.deb -O /tmp
	wget http://mirrors.ibiblio.org/apache/cassandra/3.0.0/apache-cassandra-3.0.0-bin.tar.gz -O /tmp
	wget http://mirror.cogentco.com/pub/apache/kafka/0.8.2.2/kafka_2.11-0.8.2.2.tgz -O /tmp
	wget http://mirror.metrocast.net/apache/spark/spark-1.5.2/spark-1.5.2-bin-hadoop2.6.tgz -O /tmp
	
#repo
	#sexy bash
	cd /tmp && git clone --depth 1 https://github.com/twolfson/sexy-bash-prompt && cd sexy-bash-prompt && make install) && source ~/.bashrc

	#jenkins
	wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
	sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'


	#rabbitmq
	sudo echo "deb http://www.rabbitmq.com/debian/ testing main" >> /etc/apt/sources.list
	wget https://www.rabbitmq.com/rabbitmq-signing-key-public.asc
	sudo apt-key add rabbitmq-signing-key-public.asc


	#synapse
	sudo apt-add-repository ppa:synapse-core/testing


	#vundle
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#update
	sudo apt-get update

#aptget
	#sudo apt-get install -y synapse terminator linux-image-generic-lts-trusty curl build-essential openjdk-8-jdk python-dev python-software-properties software-properties-common g++ python supervisor automake gnuplot unzip vim ant gradle maven git maven make jenkins jenkins virtualbox-guest-additions-iso kdiff3 virtualbox-guest-utils virtualbox-guest-x11 virtualbox-guest-dkms xclip mysql-client chromium-browser;
	#apps
	sudo apt-get install -y synapse terminator curl build-essential openjdk-7-jdk python-dev python-software-properties software-properties-common g++ python supervisor automake gnuplot unzip vim ant gradle maven git maven make kdiff3 xclip mysql-client chromium-browser;
	
	#virtualbox
	sudo apt-get install -y virtualbox-guest-additions-iso virtualbox-guest-utils virtualbox-guest-x11 virtualbox-guest-dkms;
	
	
	#linux image generics
	sudo apt-get install -y linux-image-generic-lts-trusty;

#permission stuffs
	sudo chown -R syle /opt/*
	sudo usermod -a -G vboxsf hduser
	sudo usermod -a -G vboxsf syle
	sudo usermod -a -G vboxsf jenkins
	sudo usermod -a -G vboxsf hadoop
	sudo usermod -a -G shadow syle
	sudo usermod -a -G shadow jenkins
	sudo usermod -a -G hadoop syle
	sudo usermod -a -G hadoop jenkins

#vim config
	#vundle
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

	#vim config: ~/.vimrc
	wget https://raw.githubusercontent.com/synle/ubuntu-setup/master/vim/.vimrc -O ~/.vimrc
	#install from command line
	vim +PluginInstall +qall

#install fish shell
	cd /tmp
	sudo dpkg -i fish-dbg_2*.deb

	#fundle : fish bundle
	wget https://raw.githubusercontent.com/tuvistavie/fundle/master/functions/fundle.fish -O ~/.config/fish/functions/fundle.fish

	#fish config:  ~/.config/fish/config.fish
	wget https://raw.githubusercontent.com/synle/ubuntu-setup/master/misc/fish.config -O ~/.config/fish/config.fish 

#install missing packages
sudo apt-get -f install


#extra
cd /home/syle/Downloads
sudo sh netbeans-8.1-linux.sh

#upgrade
sudo apt-get upgrade -y

#extra

#application shortcut
	#subl /usr/share/applications/

#node
## install nvm, node, npm
	#nvm
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash
	nvm install stable
	nvm install iojs
	nvm install v0.12.15
	#npm install npm@2.15.1 -g
	#nvm alias default v0.12.15
	nvm alias default stable
	#npm install -g nw
	npm install -g  grunt-cli grunt-init bower gulp browserify webpack eslint typings

#xcfe tweak: speed bump
#vim ~/.config/openbox/lubuntu-rc.xml
sed -i "s/<animateIconify>yes<\/animateIconify>/<animateIconify>no<\/animateIconify>/g" ~/.config/openbox/lubuntu-rc.xml

#install eclipse shortcut
wget https://raw.githubusercontent.com/synle/ubuntu-setup/master/misc/eclipse-mars-ee.desktop -O /usr/share/applications


#change shell if needed to bash if needed
#chsh -s /bin/bash




#cant be automated yet, need to be run on login
#install mysql
sudo apt-get install -y mysql-server
