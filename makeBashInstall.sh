#!/usr/bin/env bash
# os flags
is_os_darwin_mac=0
is_os_ubuntu=0
is_os_window=0
[ -d /Library ] && is_os_darwin_mac=1
[ -d /mnt/c/Users ] && is_os_window=1
apt-get -v &> /dev/null && is_os_ubuntu=1

function curlNoCache(){ curl -s "$@?$(date +%s)"; }
function echoo(){ printf "\e[1;31m$@\n\e[0m"; }

echoo "Prerequisites"
# common modules needed for mac or ubuntu or windows subsystem linux
if [ $is_os_darwin_mac == "1" ]
then
  curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.mac.darwin.sh | bash -
elif [ $is_os_ubuntu == "1" ]
then
  curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.ubuntu.aptget.sh | sudo bash -
fi

echoo "nvm & node & npm modules"
NVM_BASE_PATH=~/.nvm
# "Install nvm, node. npm and stuffs"
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.nvm.node.sh | bash -
# global npm node modules...
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.npm.node.sh | bash -
echo "  nvm node symlink"
sudo ln -f -s $NVM_BASE_PATH/versions/node/v0.12.15/bin/node /usr/local/bin/node
sudo ln -f -s $NVM_BASE_PATH/versions/node/v0.12.15/bin/npm  /usr/local/bin/npm

# common commands
# resource nvm if needed
[ -s ~/.nvm/nvm.sh ] && . ~/.nvm/nvm.sh

#################################
# script begins....
# refresh script starts here...
#################################
BASH_SYLE=~/.bash_syle
TEMP_BASH_SYLE=/tmp/.bash_syle
BASH_PATH=~/.bashrc
[ -s ~/.bash_profile ] && BASH_PATH=~/.bash_profile

echoo "Setting up in bash folder: $BASH_PATH"

grep -q -F '.bash_syle' $BASH_PATH || echo  """
#syle bash
[ -s $BASH_SYLE ] && . $BASH_SYLE
""" >> $BASH_PATH

# bash header
echo  "" > $TEMP_BASH_SYLE
echo  "#!/bin/bash" >> $TEMP_BASH_SYLE

# bash completion
echoo "Bash Completions"
echo  "  Git Completion"
curlNoCache https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash >> $TEMP_BASH_SYLE
echo  "  Grunt(Node JS) Completion"
curlNoCache https://raw.githubusercontent.com/gruntjs/grunt-cli/master/completion/bash >> $TEMP_BASH_SYLE
type grunt &> /dev/null && eval "$(grunt --completion=bash)" >> $TEMP_BASH_SYLE
echo  "  Gulp(Node JS) Completion"
curlNoCache https://raw.githubusercontent.com/gulpjs/gulp/master/completion/bash >> $TEMP_BASH_SYLE
echo  "  NPM Completion"
type npm &> /dev/null && npm completion >> $TEMP_BASH_SYLE
type npm &> /dev/null && npm set progress=false;

# bash alias
echoo "Bash Aliases"
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-alias-cmd.sh >> $TEMP_BASH_SYLE


#OSX MAC GUI Stuffs
if [ $is_os_darwin_mac == "1" ]
then
  echoo "  OSX (Darwin) specifics..."

  # mac alias
  echo  "    OSX Aliases"
  curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-util-osx.sh >> $TEMP_BASH_SYLE
else
  echoo "  Non-Mac Bash Specifics..."
  curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-util-ubuntu.sh >> $TEMP_BASH_SYLE

  if [ $is_os_window == "1" ]
  then
    WINDOWS_HOME_PATH=/mnt/c/Users/$USER
    echoo "    Windows 10 Subsystem Linux (WSL - Bash)..."
    echo  "      WSL only aliases/commands"
    curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-util-ubuntu-wsl.sh >> $TEMP_BASH_SYLE

    echo "      Default to Windows Home Dir"
    echo "# default path to Window home..." >> $TEMP_BASH_SYLE
    echo "cd /mnt/c/Users/$(whoami)" >> $TEMP_BASH_SYLE
  elif [ $is_os_ubuntu == "1" ]
  then
    echoo "    Ubuntu Debian Bash..."

    #ubuntu gui tweaks
    #lcfe tweak: speed bump
    #vim ~/.config/openbox/lubuntu-rc.xml
    [ -s ~/.config/openbox/lubuntu-rc.xml ] && \
        sed -i "s/<animateIconify>yes<\/animateIconify>/<animateIconify>no<\/animateIconify>/g" \
        ~/.config/openbox/lubuntu-rc.xml
  fi
fi


# echo  "      Reset Bash KeyMap";
# set -o vi;
#     http://unix.stackexchange.com/questions/21092/how-can-i-reset-all-the-bind-keys-in-my-bash

#added synle make component scripts...
echoo "  Make Component Scripts"
rm -rf ~/synle-make-component
git clone --depth 1 -b master https://github.com/synle/make-component.git ~/synle-make-component &> /dev/null
cd ~/synle-make-component 
npm i &> /dev/null && npm run build &> /dev/null
echo """
  # sourcing synle make component
  [ -s ~/synle-make-component/setup.sh ] && . ~/synle-make-component/setup.sh
""" >> $TEMP_BASH_SYLE
cd --

#prompt
echoo "Bash Prompt"
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-prompt.sh >> $TEMP_BASH_SYLE

echoo "Installing the New Bash File"
#copy it over
#rerun the source
mv $TEMP_BASH_SYLE $BASH_SYLE && . $BASH_PATH


#misc
#sublime
echoo "Sublime Setup"
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.sublime.sh | bash -


#eslint config
echoo "ESLint Config"
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/misc/eslintrc > ~/.eslintrc


#extra stuffs
#awesome git commands
echoo "Git Config / Aliases"
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.git.config.sh | bash -

#vim stuffs
echoo "Vim & Vundle"
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.vim.sh | bash -

#tmux stuffs
# http://www.hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/
echoo "Tmux"
echo """
set -g status off
set -g status-utf8 on

# Window options
set -g monitor-activity off
set -g automatic-rename on

# Colors
setw -g window-status-current-fg colour191
set -g status-bg default
set -g status-fg white
set -g message-bg default
set -g message-fg colour191
""" > ~/.tmux.conf
