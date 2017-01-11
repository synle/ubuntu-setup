#resource nvm if needed
[ -s /opt/nvm/nvm.sh ] && . /opt/nvm/nvm.sh;


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
