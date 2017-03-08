#resource nvm if needed
[ -s /opt/nvm/nvm.sh ] && . /opt/nvm/nvm.sh;
[ -s ~/.nvm/nvm.sh ] && . ~/.nvm/nvm.sh;


echo "Install node@v0.12.15 - stable - iojs";
nvm install v0.12.15;
nvm install stable;
nvm install iojs;
nvm alias default v0.12.15;

nvm use default;
 
echo "Install npm@2.15.1";
npm i -g npm@2.15.1;
