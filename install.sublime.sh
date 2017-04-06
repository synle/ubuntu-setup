function curlNoCache(){ curl -s "$@?$(date +%s)"; }

#################################
# script begins....
#installation script here...
##################################
needToSetUpSublime=1
dir_sublime_color_scheme_prefix="Packages\/Color Scheme - Default"
urlKeyBindings=https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/keybind-window
urlPackageControlConfig=https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/config-package-control
urlDefaultSettings=https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/config-default-sublime-theme
urlUserPreference=https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/config-user-preference
if [ -d /Library ]
then
  # mac OSX sublime
  echo "  OSX Sublime"
  echo "    Symlink: subl"
  rm -f /usr/local/bin/subl;
  ln -sf /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl;
  chmod +x /usr/local/bin/subl
  # url
  urlKeyBindings=https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/keybind-mac
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
    dir_sublime_base=/mnt/c/Users/$(whoami)/AppData/Roaming/Sublime\ Text\ 3/Packages/User
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
  echo "  Finishing Sublime Config Final Touches..."
  echo "    Keybinding"
  curlNoCache "$urlKeyBindings" > "$dir_sublime_keymap"

  echo "    Package Control Settings"
  dir_sublime_package_control=$dir_sublime_base/Package\ Control.sublime-settings
  curlNoCache "$urlPackageControlConfig" > /tmp/subl-package-control
  cat /tmp/subl-package-control > "$dir_sublime_package_control"

  echo "    Default Settings"
  curlNoCache "$urlDefaultSettings" > "$dir_sublime_base/Default.sublime-theme"

  echo "    User Settings"
  curlNoCache "$urlUserPreference" > /tmp/subl-user-settings
  sed -ie "s/{{COLOR_SCHEME_PATH}}/$dir_sublime_color_scheme_prefix/g" /tmp/subl-user-settings
  cat /tmp/subl-user-settings > "$dir_sublime_base/Preferences.sublime-settings"
  
  echo "    Snippets"
  #   aura snippets
  #   rm -f "$dir_sublime_base/aura*.sublime-*"
  curlNoCache https://raw.githubusercontent.com/synle/aura_autocomplete_sublime/master/snippet/aura.attributes.sublime-completions > "$dir_sublime_base/aura.attributes.sublime-completions"
  curlNoCache https://raw.githubusercontent.com/synle/aura_autocomplete_sublime/master/snippet/aura.cmp.sublime-syntax > "$dir_sublime_base/aura.cmp.sublime-syntax"
  curlNoCache https://raw.githubusercontent.com/synle/aura_autocomplete_sublime/master/snippet/aura.event.js.sublime-completions > "$dir_sublime_base/aura.event.js.sublime-completions"
  curlNoCache https://raw.githubusercontent.com/synle/aura_autocomplete_sublime/master/snippet/aura.helper.js.sublime-completions > "$dir_sublime_base/aura.helper.js.sublime-completions"
  curlNoCache https://raw.githubusercontent.com/synle/aura_autocomplete_sublime/master/snippet/aura.js.sublime-completions > "$dir_sublime_base/aura.js.sublime-completions"
  curlNoCache https://raw.githubusercontent.com/synle/aura_autocomplete_sublime/master/snippet/aura.uitags.sublime-completions > "$dir_sublime_base/aura.uitags.sublime-completions"


  echo "    Build System"
  # build - npm
  echo '''
{
    "working_dir": "${file_path}",
    "selector" : "source.js",
    "shell_cmd": "npm start",
    "windows" :
    {
        "shell_cmd": "bash -c \"npm start\""
    },
    "variants": [
        {
            "name": "compile a single file",
            "shell_cmd": "node $file_name",
            "windows" :
            {
                "shell_cmd": "bash -c \"node $file_name\""
            }
        },
        {
            "name": "npm start",
            "shell_cmd": "npm start",
            "windows" :
            {
                "shell_cmd": "bash -c \"npm start\""
            }
        },
        {
            "name": "npm test",
            "shell_cmd": "npm test",
            "windows" :
            {
                "shell_cmd": "bash -c \"npm test\""
            }
        },
        {
            "name": "npm install",
            "shell_cmd": "npm install",
            "windows" :
            {
                "shell_cmd": "bash -c \"npm install\""
            }
        }
    ]
}
  ''' > "$dir_sublime_base/node-npm-start.sublime-build"
fi
