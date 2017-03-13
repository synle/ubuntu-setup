function curlNoCache(){ curl -s "$@?$(date +%s)"; }

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
  echo "  OSX Sublime"
  echo "    Symlink: subl"
  rm -f /usr/local/bin/subl;
  ln -sf /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl;
  chmod +x /usr/local/bin/subl
  # url
  urlKeyBindings=https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/sublime.mac.keybinding
  # paths
  dir_sublime_base=~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
  dir_sublime_keymap=$dir_sublime_base/Default\ \(OSX\).sublime-keymap
else
  echo "  Non-Mac Environment"

  if [ -d "/mnt/c/Users" ]
  then
    # windows subsystem ubuntu bash sublime
    echo "  Windows Sublime (via Windows Subsystem Linux)"
    # url
    # paths
    dir_sublime_base=/mnt/c/Users/syle/AppData/Roaming/Sublime\ Text\ 3/Packages/User
    dir_sublime_keymap=$dir_sublime_base/Default\ \(Windows\).sublime-keymap
  elif [ -d "~/.config/sublime-text-3" ]
  then
    #ubuntu sublime
    echo "  Ubuntu Sublime"
    # url
    # paths
    dir_sublime_base=~/.config/sublime-text-3/Packages/User
    dir_sublime_keymap=$dir_sublime_base/Default\ \(Linux\).sublime-keymap
  else
    #N/A (no gui...)
    needToSetUpSublime=0
    echo "  Skip Sublime Config Settings - N/A for your machine"
  fi
fi


# only run install script if needed
if [ $needToSetUpSublime == "1" ]
then
  dir_sublime_package_control_config=$dir_sublime_base/Package\ Control.sublime-settings
  dir_sublime_default_settings=$dir_sublime_base/Default.sublime-theme
  dir_sublime_user_settings=$dir_sublime_base/Preferences.sublime-settings

  echo "  Finishing Sublime Config Final Touches..."
  echo "    Keybinding"
  curlNoCache "$urlKeyBindings" > "$dir_sublime_keymap"

  echo "    Package Control Settings"
  curlNoCache "$urlPackageControlConfig" > "$dir_sublime_package_control_config"

  echo "    Default Settings"
  curlNoCache "$urlDefaultSettings" > "$dir_sublime_default_settings"

  echo "    User Settings"
  curlNoCache "$urlUserPreference" > /tmp/subl-user-settings
  sed -ie "s/{{COLOR_SCHEME_PATH}}/$dir_sublime_color_scheme_prefix/g" /tmp/subl-user-settings
  cat /tmp/subl-user-settings > "$dir_sublime_user_settings"
  
  
  echo "    Build System"
  echo """
    {
        "cmd": ["/usr/local/bin/node", "$file"],
        "working_dir": "$file_path",
        "selector" : "source.js",
        "windows" : {
            "shell": true
        }
    }
  """ > node-js.sublime-build
fi
