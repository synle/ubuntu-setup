##################################################################
# begin prep work #
##################################################################
BASH_SYLE=~/.bash_syle
TEMP_BASH_SYLE=/tmp/.bash_syle
BASH_PATH=~/.bashrc

# os flags
is_os_darwin_mac=0
is_os_ubuntu=0
is_os_redhat=0
is_os_window=0
[ -d /Library ] && is_os_darwin_mac=1
[ -d /mnt/c/Users ] && is_os_window=1
apt -v &> /dev/null && is_os_ubuntu=1
apt-get -v &> /dev/null && is_os_ubuntu=1
yum -v &> /dev/null && is_os_redhat=1

# prep works...
# go to home and start
cd ~

# common functions
function curlNoCache(){ curl -s "$@?$(date +%s)"; }
function echoo(){ printf "\e[1;31m$@\n\e[0m"; }
##################################################################
# end prep work #
##################################################################





sudo echo 'Initialize with sudo access...'

echoo "Setting up in bash folder: $BASH_PATH";
touch $BASH_PATH;

echoo "Prerequisites"
# common modules needed for mac or ubuntu or windows subsystem linux
if [ $is_os_darwin_mac == "1" ]
then
  curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.mac.darwin.sh | bash -
elif [ $is_os_ubuntu == "1" ]
then
  curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.ubuntu.aptget.sh | sudo bash -
fi


#################################
# script begins....
# refresh script starts here...
#################################
# bash header
# bash completion
# bash alias
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/makeBashMinimalInstall.sh | bash -


#OSX MAC GUI Stuffs
if [ $is_os_darwin_mac == "1" ]
then
  echoo "  OSX (Darwin) specifics..."

  # mac alias
  echo  "    OSX Aliases"
  curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-util-osx.sh >> $BASH_SYLE
else
  echoo "  Non-Mac Bash Specifics..."
  curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-util-ubuntu.sh >> $BASH_SYLE

  if [ $is_os_window == "1" ]
  then
    WINDOWS_HOME_PATH=/mnt/c/Users/$USER
    # fail safe for /mnt/c/Users/Sy Le
    [ -d $WINDOWS_HOME_PATH ] || WINDOWS_HOME_PATH="/mnt/c/Users/Sy Le"
    WINDOWS_APPDATA_PATH=$WINDOWS_HOME_PATH/AppData
    WINDOWS_DOWNLOAD_PATH=$WINDOWS_HOME_PATH/Download
    WINDOWS_DESKTOP_PATH=$WINDOWS_HOME_PATH/Desktop
    echoo "    Windows 10 Subsystem Linux (WSL - Bash)..."
    echo  "      WSL only aliases/commands"
    curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-util-ubuntu-wsl.sh >> $BASH_SYLE

    echoo "      Default to Windows Home Dir"
    echo "# default path to Window home..." >> $BASH_SYLE
    echo "cd \"$WINDOWS_HOME_PATH\"" >> $BASH_SYLE


    echoo "      Downloading some exe"
    mkdir -p /mnt/c/opt

    #yank - pbcopy and pbpaste
    echo  "        Win32Yank (pbcopy & pbpaste)"
    [ -s /mnt/c/opt/win32yank.exe ] || curl https://raw.githubusercontent.com/synle/ubuntu-setup/master/windows/binary/win32yank.exe -o /mnt/c/opt/win32yank.exe
    sudo ln -f -s /mnt/c/opt/win32yank.exe /usr/local/bin/win32yank
    echo '''
      #/usr/bin/bash
      win32yank.exe -i
    ''' > /tmp/pbcopy
    echo '''
      #/usr/bin/bash
      win32yank.exe -o
    ''' > /tmp/pbpaste
    sudo mv /tmp/pbpaste /usr/local/bin/pbpaste
    sudo mv /tmp/pbcopy /usr/local/bin/pbcopy
    sudo chmod +x /usr/local/bin/pbcopy /usr/local/bin/pbpaste


    #subl
    echo  "        Sublime Alias"
    echo '''
      #/usr/bin/bash
      subl.exe $@
    ''' > /tmp/subl
    sudo mv /tmp/subl /usr/local/bin/subl
    sudo chmod +x /usr/local/bin/subl


    #subl
    echo  "        Open (Explorer.exe)"
    echo '''
      #/usr/bin/bash
      inputToOpen=$@

      echo "open $inputToOpen"

      case "$inputToOpen" in
          http*)
              chrome.exe $inputToOpen
          ;;
          *)
              explorer.exe $inputToOpen
          ;;
      esac
    ''' > /tmp/open
    sudo mv /tmp/open /usr/local/bin/open
    sudo chmod +x /usr/local/bin/open


    #adb and fastboot
    echo  "        Android ADB and Fastboot"
    echo '''
      #/usr/bin/bash
      adb.exe $@
    ''' > /tmp/adb
    echo '''
      #/usr/bin/bash
      fastboot.exe $@
    ''' > /tmp/fastboot
    sudo mv /tmp/adb /usr/local/bin/adb
    sudo mv /tmp/fastboot /usr/local/bin/fastboot
    sudo chmod +x /usr/local/bin/adb /usr/local/bin/fastboot


    #force cli
    echo  "        force-cli (Salesforce)"
    [ -s /mnt/c/opt/force.exe ]     || curl https://s3-us-west-2.amazonaws.com/force-cli/heroku/force/v0.22.67/windows-amd64/force.exe -o /mnt/c/opt/force.exe
    sudo ln -f -s /mnt/c/opt/force.exe /usr/local/bin/force

    echoo "      Settings"
    echo  "        Theme Tweaks"
    curl https://raw.githubusercontent.com/synle/ubuntu-setup/master/windows/my.theme -so $WINDOWS_APPDATA_PATH/Local/Microsoft/Windows/Themes/sy.theme

    echoo "        Regedit"
    curl https://raw.githubusercontent.com/synle/ubuntu-setup/master/windows/regedit/core.reg -so $WINDOWS_DESKTOP_PATH/setup1.reg

#     echoo "        Powershell Commands"
#     curl https://raw.githubusercontent.com/synle/ubuntu-setup/master/windows/cleanup-window-powershell -so $WINDOWS_DESKTOP_PATH/setup2.ps1

#     echoo "        Greenshots"
#     curl https://raw.githubusercontent.com/synle/ubuntu-setup/master/windows/misc/greenshot.ini -so $WINDOWS_APPDATA_PATH/Roaming/Greenshot/Greenshot.ini

#     echoo "        AutoIt Script"
#     curl https://raw.githubusercontent.com/synle/ubuntu-setup/master/windows/misc/autoit-resize.au3 -so $WINDOWS_DESKTOP_PATH/autoit-resize.au3

  elif [ $is_os_ubuntu == "1" ]
  then
    echoo "    Ubuntu Debian Bash..."
    echo "         Bash for Git With GUI"
    curl https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-ubuntu-with-gui.sh >> $BASH_SYLE
    echo "         Install Xclip"
    sudo apt-get install -y xclip



    #ubuntu gui tweaks
    #lcfe tweak: speed bump
    #vim ~/.config/openbox/lubuntu-rc.xml
#     [ -s ~/.config/openbox/lubuntu-rc.xml ] && \
#         sed -i "s/<animateIconify>yes<\/animateIconify>/<animateIconify>no<\/animateIconify>/g" \
#         ~/.config/openbox/lubuntu-rc.xml
  fi
fi


# echo  "      Reset Bash KeyMap";
# set -o vi;
#     http://unix.stackexchange.com/questions/21092/how-can-i-reset-all-the-bind-keys-in-my-bash


# echoo "Installing the New Bash File"
# #copy it over
# #rerun the source
# . $BASH_PATH


#misc
#sublime
echoo "Sublime Setup"
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.sublime.sh | bash -


# #extra stuffs
# echo """
# #scrolling speed
# bind -n WheelUpPane   select-pane -t= \; copy-mode -e \; send-keys -M \; send-keys -M \; send-keys -M \; send-keys -M
# bind -n WheelDownPane select-pane -t= \;                 send-keys -M \; send-keys -M \; send-keys -M \; send-keys -M
# #set inactive/active window styles
# set -g window-style 'fg=colour250,bg=colour234'
# set -g window-active-style 'fg=colour250,bg=black'
# """ >> ~/.tmux.conf
