is_ubuntu=0
apt-get -v &> /dev/null && is_ubuntu=1
if [ $is_ubuntu == "1" ]; then
  echo "Ubuntu apt-get install...";
  sudo apt-get install -y curl build-essential openjdk-7-jdk python-dev python-software-properties software-properties-common g++ python supervisor automake gnuplot unzip vim ant gradle maven git maven make mysql-client;
fi


echo "Install nvm"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.7/install.sh | bash;

#source the bash profile
echo "Resource Bash Profile for nvm binary"
BASH_PROFILE_HOME_DIRECTORY=~/.bashrc
if [ "$(uname)" == "Darwin" ]; then
	export BASH_PROFILE_HOME_DIRECTORY=~/.bash_profile
fi
. ${BASH_PROFILE_HOME_DIRECTORY}



#node --version
#v0.12.15
echo "Install node@v0.12.15";
nvm install v0.12.15;
nvm alias default v0.12.15;
 
#npm --version
#2.15.1
echo "Install npm@2.15.1";
npm install npm@2.15.1 -g;

#download node npm deps
echo "Install Global Node Packages";
npm i -g  grunt-cli grunt-init bower gulp browserify webpack eslint typings;
