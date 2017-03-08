is_os_darwin_mac=0
is_os_ubuntu=0
is_os_window=0


[ -d /Library ] && is_os_darwin_mac=1 && echo "is_os_darwin_mac"
[ -d /mnt/c/Users ] && is_os_window=1 && echo "is_os_window"
# [ -d /mnt/c/Users/syle/AppData/Roaming ] && is_os_window=1 && echo "is_os_window"
[ -d ~/.config/sublime-text-3 ] && is_os_ubuntu=1 && echo "is_os_ubuntu"


if [ $is_os_darwin_mac == "1" ]
then
  #mac sublime
  echo "      OSX Sublime"
  echo "         Symlink: subl"
  rm -f /usr/local/bin/subl;
  ln -sf /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl;
  chmod +x /usr/local/bin/subl;

  echo "         Mac Keybinding"
  curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/sublime.mac.keybinding \
        > ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Default\ \(OSX\).sublime-keymap


  echo "         Package Control Settings"
  curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/PackageControl.sublime-settings \
        > ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Package\ Control.sublime-settings

  echo "         Default Settings"
  curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/Default.sublime-theme \
        > ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Default.sublime-theme

  echo "         User Settings"
  curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/Preferences.mac.sublime-settings \
        > /tmp/subl.user.settings \
  && curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/Preferences.sublime-settings  \
        >> /tmp/subl.user.settings
  cat /tmp/subl.user.settings > ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
elif [ $is_os_window == "1" ]
then
  #windows subsystem ubuntu bash sublime
  echo "      Windows Sublime"

  echo "         Windows Keybinding"
  curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/sublime.window.keybinding \
        > /mnt/c/Users/syle/AppData/Roaming/Sublime\ Text\ 3/Packages/User/Default\ \(Windows\).sublime-keymap
  
  echo "         Package Control Settings"
  curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/PackageControl.sublime-settings \
        > /mnt/c/Users/syle/AppData/Roaming/Sublime\ Text\ 3/Packages/User/Package\ Control.sublime-settings
        
  echo "         Default Settings"
  curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/Default.sublime-theme \
        > /mnt/c/Users/syle/AppData/Roaming/Sublime\ Text\ 3/Packages/User/Default.sublime-theme

  echo "         User Settings"
  curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/Preferences.windows.sublime-settings  \
        > /tmp/subl.user.settings \
  && curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/Preferences.sublime-settings  \
        >> /tmp/subl.user.settings
  cat /tmp/subl.user.settings > /mnt/c/Users/syle/AppData/Roaming/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
elif [ $is_os_ubuntu == "1" ]
then
  #ubuntu sublime
  echo "         Linux Keybinding"
  curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/sublime.window.keybinding \
        > ~/.config/sublime-text-3/Packages/User/Default\ \(Linux\).sublime-keymap


  echo "         Package Control Settings"
  curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/PackageControl.sublime-settings \
        > ~/.config/sublime-text-3/Packages/User/Package\ Control.sublime-settings
        
  echo "         Default Settings"
  curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/Default.sublime-theme \
        > ~/.config/sublime-text-3/Packages/User/Default.sublime-theme

  echo "         User Settings"
  curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/Preferences.windows.sublime-settings  \
        > /tmp/subl.user.settings \
  && curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/Preferences.sublime-settings  \
        >> /tmp/subl.user.settings
  cat /tmp/subl.user.settings \
    > ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings
else
  #N/A
  echo "Skip Sublime Config Settings - N/A for your machine"
fi
