function curlNoCache(){
  curl -so- -H 'Cache-Control: no-cache' "$@?$(date +%s)"
}

#################################
# script begins....
#installation script here...
##################################
needToSetUpSublime=1
dir_sublime_color_scheme_prefix="Packages\/Color Scheme - Default"
urlKeyBindings=https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/sublime.window.keybinding
urlPackageControlConfig=https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/PackageControl.sublime-settings
urlDefaultSettings=https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/Default.sublime-theme
urlUserPreference=https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/Preferences.sublime-settings
if [ -d /Library ]
then
  # mac OSX sublime
  echo "    OSX Sublime"
  echo "      Symlink: subl"
  rm -f /usr/local/bin/subl;
  ln -sf /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl;
  chmod +x /usr/local/bin/subl
  # url
  urlKeyBindings=https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/sublime.mac.keybinding
  # paths
  dir_sublime_keymap=~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Default\ \(OSX\).sublime-keymap
  dir_sublime_package_control_config=~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Package\ Control.sublime-settings
  dir_sublime_default_settings=~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Default.sublime-theme
  dir_sublime_user_settings=~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
else
  echo "  Non-Mac Environment"

  if [ -d "/mnt/c/Users" ]
  then
    # windows subsystem ubuntu bash sublime
    echo "  Windows Sublime (via Windows Subsystem Linux)"
    # url
    # paths
    dir_sublime_keymap=/mnt/c/Users/syle/AppData/Roaming/Sublime\ Text\ 3/Packages/User/Default\ \(Windows\).sublime-keymap
    dir_sublime_package_control_config=/mnt/c/Users/syle/AppData/Roaming/Sublime\ Text\ 3/Packages/User/Package\ Control.sublime-settings
    dir_sublime_default_settings=/mnt/c/Users/syle/AppData/Roaming/Sublime\ Text\ 3/Packages/User/Default.sublime-theme
    dir_sublime_user_settings=/mnt/c/Users/syle/AppData/Roaming/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
  elif [ -d "~/.config/sublime-text-3" ]
  then
    #ubuntu sublime
    echo "  Ubuntu Sublime"
    # url
    # paths
    dir_sublime_keymap=~/.config/sublime-text-3/Packages/User/Default\ \(Linux\).sublime-keymap
    dir_sublime_package_control_config=~/.config/sublime-text-3/Packages/User/Package\ Control.sublime-settings
    dir_sublime_default_settings=~/.config/sublime-text-3/Packages/User/Default.sublime-theme
    dir_sublime_user_settings=~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings
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
  curlNoCache "$urlKeyBindings" > "$dir_sublime_keymap"

  echo "      Package Control Settings"
  curlNoCache "$urlPackageControlConfig" > "$dir_sublime_package_control_config"

  echo "      Default Settings"
  curlNoCache "$urlDefaultSettings" > "$dir_sublime_default_settings"

  echo "      User Settings"
  curlNoCache "$urlUserPreference" > /tmp/subl-user-settings
  sed -ie "s/{{COLOR_SCHEME_PATH}}/$dir_sublime_color_scheme_prefix/g" /tmp/subl-user-settings
  cat /tmp/subl-user-settings > "$dir_sublime_user_settings"
fi
