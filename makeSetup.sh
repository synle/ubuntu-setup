sudo apt-get install -y curl build-essential openjdk-7-jdk python-dev python-software-properties software-properties-common g++ python supervisor automake gnuplot unzip vim ant gradle maven git maven make mysql-client;

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.7/install.sh | bash;

#source the bash profile
BASH_PROFILE_HOME_DIRECTORY=~/.bashrc
if [ "$(uname)" == "Darwin" ]; then
	export BASH_PROFILE_HOME_DIRECTORY=~/.bash_profile
fi
. ${BASH_PROFILE_HOME_DIRECTORY}



#node --version
#v0.12.15
nvm install v0.12.15
nvm alias default v0.12.15
 
#npm --version
#2.15.1

#download node npm deps
npm i -g  grunt-cli grunt-init bower gulp browserify webpack eslint typings;
