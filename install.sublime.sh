#flags
is_os_darwin_mac=0
[ -d /Library ] && is_os_darwin_mac=1

function curlNoCache(){
  curl -so- -H 'Cache-Control: no-cache' "$@?$(date +%s)"
}

#################################
# script begins....
#installation script here...
##################################
needToSetUpSublime=1
urlKeyBindings=https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/sublime.window.keybinding
if [ $is_os_darwin_mac == "1" ]
then
  #mac sublime
  echo "    OSX Sublime"
  echo "      Symlink: subl"
  rm -f /usr/local/bin/subl;
  ln -sf /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl;
  chmod +x /usr/local/bin/subl;

  echo "      Mac Keybinding"
  curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/sublime.mac.keybinding \
      > ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Default\ \(OSX\).sublime-keymap


  echo "      Package Control Settings"
  curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/PackageControl.sublime-settings \
      > ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Package\ Control.sublime-settings

  echo "      Default Settings"
  curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/Default.sublime-theme \
      > ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Default.sublime-theme

  echo "      User Settings"
  curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/Preferences.mac.sublime-settings \
      > /tmp/subl.user.settings \
  && curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/Preferences.sublime-settings  \
      >> /tmp/subl.user.settings
  cat /tmp/subl.user.settings > ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
else
  echo "  Non-Mac Environment"

  if [ -d "/mnt/c/Users" ]
  then
    #windows subsystem ubuntu bash sublime
    dir_sublime_keymap=/mnt/c/Users/syle/AppData/Roaming/Sublime\ Text\ 3/Packages/User/Default\ \(Windows\).sublime-keymap
    dir_sublime_package_control_config=/mnt/c/Users/syle/AppData/Roaming/Sublime\ Text\ 3/Packages/User/Package\ Control.sublime-settings
    dir_sublime_default_settings=/mnt/c/Users/syle/AppData/Roaming/Sublime\ Text\ 3/Packages/User/Default.sublime-theme
    dir_sublime_user_settings=/mnt/c/Users/syle/AppData/Roaming/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
    echo "  Windows Sublime (via Windows Subsystem Linux)"
  elif [ -d "~/.config/sublime-text-3" ]
  then
    #ubuntu sublime
    dir_sublime_keymap=~/.config/sublime-text-3/Packages/User/Default\ \(Linux\).sublime-keymap
    dir_sublime_package_control_config=~/.config/sublime-text-3/Packages/User/Package\ Control.sublime-settings
    dir_sublime_default_settings=~/.config/sublime-text-3/Packages/User/Default.sublime-theme
    dir_sublime_user_settings=~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings
    echo "  Ubuntu"
  else
    #N/A (no gui...)
    needToSetUpSublime=0
    echo "  Skip Sublime Config Settings - N/A for your machine"
  fi
fi


# only run install script if needed
if [ $needToSetUpSublime == "1" ]
then
  echo "    Finishing Sublime Config Final Touches..."
  echo "      Keybinding"
    curlNoCache "$urlKeyBindings" \
        > "$dir_sublime_keymap"

  echo "      Package Control Settings"
  curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/PackageControl.sublime-settings \
      > "$dir_sublime_package_control_config"

  echo "      Default Settings"
  curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/Default.sublime-theme \
      > "$dir_sublime_default_settings"

  echo "      User Settings"
  curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/Preferences.windows.sublime-settings  \
      > "$dir_sublime_user_settings"
  curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/Preferences.sublime-settings  \
      >> "$dir_sublime_user_settings"
fi
