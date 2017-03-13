#!/usr/bin/env bash
# os flags
is_os_darwin_mac=0
is_os_ubuntu=0
is_os_window=0
[ -d /Library ] && is_os_darwin_mac=1
[ -d /mnt/c/Users ] && is_os_window=1
apt-get -v &> /dev/null && is_os_ubuntu=1

function curlNoCache(){ curl -so- -H 'Cache-Control: no-cache' "$@?$(date +%s)"; }
function echoo(){ printf "\e[1;33m$@\n\e[0m"; }

echoo "Prerequisites"
# common modules needed for mac or ubuntu or windows subsystem linux
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.mac.darwin.sh | bash -
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.ubuntu.aptget.sh | bash -

echoo "nvm & node & npm modules"
# "Install nvm, node. npm and stuffs"
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.nvm.node.sh | bash -
# global npm node modules...
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.npm.node.sh | bash


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

  # mac brew install
  echo  "    OSX Brew"

  # mac alias
  echo  "    OSX Aliases"
  curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-util-osx.sh >> $TEMP_BASH_SYLE

  # mac options
  echo  "    OSX Options"
  curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/mac/mac.setup.sh | bash -
else
  echoo "  Non-Mac Bash Specifics..."
  curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-util-ubuntu.sh >> $TEMP_BASH_SYLE

  if [ $is_os_window == "1" ]
  then
    WINDOWS_HOME_PATH=/mnt/c/Users/$USER
    echoo "    Windows 10 Subsystem Linux (WSL - Bash)..."
    echo  "      WSL only aliases/commands"
    curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-util-ubuntu-wsl.sh >> $TEMP_BASH_SYLE

    echo  "        Install CBWin"
    if [ ! -d "/mnt/c/cbwin" ]
    then
      echo  "        INSTALL"

      cd /tmp
        echo  "        Cloning"
        rm -rf cbwin* master.zip cbwin-bin*.zip
        wget https://github.com/xilun/cbwin/releases/download/v0.13/cbwin-bin-0.13.zip &> /dev/null
        unzip cbwin-bin*.zip &> /dev/null
        rm cbwin-bin*.zip
        mv cbwin* cbwin
        mv cbwin* /mnt/c

        cd /mnt/c/cbwin
          echo  "        Install binary for outbash.exe"
          sudo ./install.sh
        cd --
      cd --

      echoo "      HyperTerm (Console)"
      echo  "        HyperTerm Config"
      curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/windows/hyperterm.js > $WINDOWS_HOME_PATH/.hyper.js
    else
      echo  "        SKIP"
    fi
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
