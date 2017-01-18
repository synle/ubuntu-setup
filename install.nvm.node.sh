#resource nvm if needed
[ -s /opt/nvm/nvm.sh ] && . /opt/nvm/nvm.sh;
[ -s ~/.nvm/nvm.sh ] && . ~/.nvm/nvm.sh;


echo "Install node@v0.12.15 - stable - iojs";
nvm install v0.12.15;
nvm install stable;
nvm install iojs;
nvm alias default v0.12.15;


#resource nvm if needed
[ -s /opt/nvm/nvm.sh ] && . /opt/nvm/nvm.sh;
[ -s ~/.nvm/nvm.sh ] && . ~/.nvm/nvm.sh;

nvm use default;
 
echo "Install npm@2.15.1";
npm i -g npm@2.15.1;

#download node npm deps
echo "Install Global Node Packages";
npm i -g grunt-cli;
npm i -g grunt-init;
npm i -g bower;
npm i -g gulp;
npm i -g browserify;
npm i -g webpack;
npm i -g eslint;
npm i -g typings;
