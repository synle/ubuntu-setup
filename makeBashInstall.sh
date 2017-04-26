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
    WINDOWS_APPDATA_PATH=$WINDOWS_HOME_PATH/AppData
    WINDOWS_DOWNLOAD_PATH=$WINDOWS_HOME_PATH/Download
    WINDOWS_DESKTOP_PATH=$WINDOWS_HOME_PATH/Desktop
    echoo "    Windows 10 Subsystem Linux (WSL - Bash)..."
    echo  "      WSL only aliases/commands"
    curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-util-ubuntu-wsl.sh >> $TEMP_BASH_SYLE

    echoo "      Default to Windows Home Dir"
    echo "# default path to Window home..." >> $TEMP_BASH_SYLE
    echo "cd /mnt/c/Users/$(whoami)" >> $TEMP_BASH_SYLE
    
    
    echoo "      Downloading some exe"
    mkdir -p /mnt/c/opt
    echo  "        Win32Yank (pbcopy & pbpaste)"
    [ -s /mnt/c/opt/win32yank.exe ] || curl https://raw.githubusercontent.com/synle/ubuntu-setup/master/windows/binary/win32yank.exe -o /mnt/c/opt/win32yank.exe
    sudo ln -f -s /mnt/c/opt/win32yank.exe /usr/local/bin/win32yank
    echo  "        force-cli (Salesforce)"
    [ -s /mnt/c/opt/force.exe ]     || curl https://s3-us-west-2.amazonaws.com/force-cli/heroku/force/v0.22.67/windows-amd64/force.exe -o /mnt/c/opt/force.exe
    sudo ln -f -s /mnt/c/opt/force.exe /usr/local/bin/force
    
    echoo "      Settings"
    echo  "        Theme Tweaks"
    curl https://raw.githubusercontent.com/synle/ubuntu-setup/master/windows/my.theme -so $WINDOWS_APPDATA_PATH/Local/Microsoft/Windows/Themes/sy.theme
    
    echoo "        Regedit"
    curl https://raw.githubusercontent.com/synle/ubuntu-setup/master/windows/regedit/core.reg -so $WINDOWS_DESKTOP_PATH/setup1.reg
    
    echoo "        Powershell Commands"
    curl https://raw.githubusercontent.com/synle/ubuntu-setup/master/windows/cleanup-window-powershell -so $WINDOWS_DESKTOP_PATH/setup2.ps1
    
    echoo "        Greenshots"
    curl https://raw.githubusercontent.com/synle/ubuntu-setup/master/windows/misc/greenshot.ini -so $WINDOWS_APPDATA_PATH/Roaming/Greenshot/Greenshot.ini
    
    echoo "        AutoIt Script"
    curl https://raw.githubusercontent.com/synle/ubuntu-setup/master/windows/misc/autoit-resize.au3 -so $WINDOWS_DESKTOP_PATH/autoit-resize.au3
    
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
nohup npm i &> /dev/null && npm run build &> /dev/null &
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
# https://superuser.com/questions/209437/how-do-i-scroll-in-tmux
# http://stackoverflow.com/questions/25532773/change-background-color-of-active-or-inactive-pane-in-tmux/33553372#33553372
echoo "Tmux"
echo """
#set inactive/active window styles
set -g window-style 'fg=colour247,bg=colour236'
set -g window-active-style 'fg=colour250,bg=black'

# set the pane border colors 
set -g pane-border-fg colour250
set -g pane-border-bg colour236
set -g pane-active-border-fg colour250 
set -g pane-active-border-bg colour250

#not show status bar
set -g status off


#mouse support
set -g mouse on

#scroll history
set -g history-limit 30000

#scrolling speed
bind -n WheelUpPane   select-pane -t= \; copy-mode -e \; send-keys -M \; send-keys -M \; send-keys -M \; send-keys -M 
bind -n WheelDownPane select-pane -t= \;                 send-keys -M \; send-keys -M \; send-keys -M \; send-keys -M 

# Window options
set -g monitor-activity off
""" > ~/.tmux.conf


# fzf
echoo "fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf  &> /dev/null
~/.fzf/install  &> /dev/null
