#!/usr/bin/env bash
NVM_BASE_PATH=~/.nvm

# resource nvm
. "$NVM_BASE_PATH/nvm.sh"

#download node npm deps
echo "  npm i -g";
npm i -g \
#     grunt-init \
    bower \
    gulp \
    browserify \
    webpack \
    eslint \
    typings \
    less \
    create-react-app
