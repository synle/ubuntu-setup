#!/usr/bin/env bash
NVM_BASE_PATH=~/.nvm

# resource nvm
. "$NVM_BASE_PATH/nvm.sh"

#download node npm deps
echo "  npm i -g";
echo "    begin global modules npm installs" && npm i -g \
    webpack \
    eslint \
    typings \
    less \
    create-react-app \
    ember-cli \
&& echo "    end global modules npm installs"
