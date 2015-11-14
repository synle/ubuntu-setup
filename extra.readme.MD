#fish auto complete
```
#npm
curl https://raw.githubusercontent.com/fish-shell/fish-shell/master/share/completions/npm.fish -o ~/.config/fish/functions/npm.fish
```


#mysql
```
sudo apt-get install -y mysql-server;
```

#jenkins set up
```
git plugin
AnsiColor Plugin
```

#jenkins email notification
```
server: smtp.gmail.com
username: email@gmail.com
SSL & PORT: 465
```


Symlink jenkins home
```
#sudo ln -s /var/lib/jenkins/ /home
sudo ln -s /var/lib/jenkins/ ~/jenkins_home
```


======

# For Macbook
```
keyboard (remap Ctrl and Cmd): https://radu.cotescu.com/remapping-keys-in-ubuntu-14.04/
```

## mapping
```
sudo vim /usr/share/X11/xkb/symbols/pc
key <LCTL> {    [ Super_L       ]   };
key <LWIN> {    [ Control_L     ]   };
```

## remove cache
```
rm -rf /var/lib/xkb/*
```

keyboard (disable fn by default): http://ubuntuforums.org/showthread.php?t=1631545
```
     sudo su -c "echo -n 0x02 > /sys/module/hid_apple/parameters/fnmode"
```

touchpad (overall) : https://help.ubuntu.com/community/MacBookPro7-1/Lucid#Keyboard


touchpad: http://yarenty.blogspot.com/2014/08/how-to-fix-macbook-pro-touchpad-on.html?m=1
## install mtrack
```
sudo apt-get install xserver-xorg-input-mtrack
```

## settings
`sudo vim /usr/share/X11/xorg.conf.d/50-synaptics.conf`
```
Section "InputClass"
    MatchIsTouchpad "on"
    Identifier      "Touchpads"
    Driver          "mtrack"
    Option          "Sensitivity" "0.80"
    Option          "FingerHigh" "12"
    Option          "FingerLow" "1"
    Option          "IgnoreThumb" "true"
    Option          "IgnorePalm" "true"
    Option          "TapButton1" "0"
    Option          "TapButton2" "0"
    Option          "TapButton3" "0"
    Option          "TapButton4" "0"
    Option          "ClickFinger1" "1"
    Option          "ClickFinger2" "3"
    Option          "ClickFinger3" "3"
    Option          "ButtonMoveEmulate" "false"
    Option          "ButtonIntegrated" "true"
    Option          "ClickTime" "25"
    Option          "BottomEdge" "25"
    Option          "SwipeLeftButton" "8"
    Option          "SwipeRightButton" "9"
    Option          "SwipeUpButton" "0"
    Option          "SwipeDownButton" "0"
    Option          "ScrollDistance" "65"
EndSection
```



## Netflix
```
sudo add-apt-repository ppa:ehoover/compholio
sudo apt-get update && sudo apt-get install -y netflix-desktop
sudo apt-get install -y --reinstall ttf-mscorefonts-installer
```


## XCFE Tweaks
Speed up user interface
```
vim .gtkrc-2.0
    gtk-menu-popup-delay = 0
    gtk-menu-popdown-delay = 0
    gtk-menu-bar-popup-delay = 0
    gtk-enable-animations = 0
    gtk-timeout-expand = 0
    gtk-timeout-initial = 0
    gtk-timeout-repeat = 0

```



## Atom Plugins
```
/Users/syle/.atom/packages (8)
├── atom-beautify@0.28.14
├── file-icons@1.6.11
├── fixmyjs@1.3.4
├── git-plus@5.4.7
├── pigments@0.18.0
├── split-diff@0.4.4
├── synced-sidebar@0.4.2
└── travis-ci-status@0.18.0

/Users/sle/.atom/packages (13)
├── atom-beautify@0.28.20
├── docblockr@0.7.3
├── file-icons@1.6.13
├── language-javascript-jsx@0.3.7
├── linter@1.11.3
├── linter-eslint@5.2.7
├── minimap@4.19.0
├── minimap-git-diff@4.1.8
├── pdf-view@0.39.0
├── split-diff@0.5.3
├── svg-preview@0.7.3
├── synced-sidebar@0.4.3
└── tree-view-git-status@0.2.2
```


## Sublime Text
```
Theme
Theme - Glacier

Settings
{
    "font_size": 12,
    "hot_exit": false,
    "remember_open_files": false,
    "theme": "Glacier.sublime-theme",
    "highlight_line" : true,
    "line_padding_top" : 1,
    "bold_folder_labels" : true
}

keybinding
custom keybinding
//custom keyboard shortcut for sy
[
    { "keys": ["super+\\"], "command": "toggle_side_bar" }
]

plugins
{
	"bootstrapped": true,
	"in_process_packages":
	[
	],
	"installed_packages":
	[
		"Alignment",
		"All Autocomplete",
		"Autoprefixer",
		"Babel",
		"BracketHighlighter",
		"CodeFormatter",
		"Color Highlighter",
		"DocBlockr",
		"FileDiffs",
		"GitGutter",
		"LESS",
		"Package Control",
		"Sass",
		"SideBarEnhancements",
		"SyncedSideBar",
		"TrailingSpaces"
	]
}
```


## git config: .gitignore
```
[alias]
    graph = log --oneline --decorate --graph
    unstage = reset HEAD .
    co = checkout
    fap = fetch --all --prune
    stat = status
[merge]
    tool = kdiff3
[diff]
    tool = kdiff3
```


#chrome no avatar
```
--disable-new-avatar-menu
```

#set new host name
http://askubuntu.com/questions/87665/how-do-i-change-the-hostname-without-a-restart
```at
hostnamectl set-hostname new-hostname
```

#higher resolution for guest virtualbox
```
/etc/default/grub
GRUB_GFXMODE=1152x864x32

update-grub2
```



#heroku tricks
```
clone:
heroku git:clone -a myapp

use existing remote:
heroku git:remote -a myapp
```


#cool netstat tricks
```
netstat --listen
netstat --vatn
```


# Salesforce aura command
```
mvn verify -DskipUnitTests -DskipJsDoc -DskipComponentCompile -DrunIntTests -Pdesktop -DtestNameContains=testToday
mvn verify -DskipUnitTests -DskipJsDoc -DskipComponentCompile -DrunIntTests -Pdesktop -DtestNameContains=testToday -Duser.timezone=PST
```



# git merge tool (kdiff3 on mac)
```
#Install on mac
sudo ln -s /Applications/kdiff3.app/Contents/MacOS/kdiff3 /usr/bin/kdiff3

#config
git config --global merge.tool kdiff3
```


# git cheat sheet
```
- [] checkbox

@mention people
#bug issue
:emoticon
```


# git split commit into smaller commits using interactive
```
git rebase -i
moved commit to last

git reset --mixed HEAD^

git add -p 
to split

git commit
```

# git split commit using checkout -p
```
git checkout -p commit_id
```

#sublime test build command
```
     Node JS
     {
         "cmd": ["node","$file"]
     }
```



# SSH Without password
```
Connection to different host(s)
on the host you will connect FROM:
generate the public private keys
> ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
copy the public key to every host you will connect TO:
> scp ~/.ssh/id_dsa.pub my_user_id@1.2.3.4:~/.ssh/id_dsa.pub

* this should prompt you for a password
shell into the remote machine
> ssh my_user_id@1.2.3.4

authorize the key by adding it to the list of authorized keys
> cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys

log out of the current shell
> exit

test that you can log in with no password
ssh -i ~/.ssh/id_dsa 1.2.3.4

if this prompts for a password
> ensure the remote user is the owner of the pub key
```


# Extra useful bash commands
```
Find Files
find . -name "*xyz*" -ls


Find tabs
grep --color "mmulani" * | grep --color "tabs" |  cut -d ":" -f 1


Cut by delimeter
cut -d ':' -f 1


Cut fixed number of characters
cat ~/a.txt  | cut -c1-6
```



# MySQL for remote
```
http://stackoverflow.com/questions/1559955/host-xxx-xx-xxx-xxx-is-not-allowed-to-connect-to-this-mysql-server

#vim /etc/mysql/my.cnf
#bind-address           = 127.0.0.1
#skip-networking

mysql -u root -h localhost -p  

CREATE USER 'syle'@'localhost' IDENTIFIED BY 'password_here';
CREATE USER 'syle'@'%' IDENTIFIED BY 'password_here';
GRANT ALL PRIVILEGES ON *.* TO 'syle'@'localhost'   WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'syle'@'%'   WITH GRANT OPTION;
```



#Survival fish
```
function fish_prompt
     set_color red
     echo "================================="
     set_color yellow
     echo [(date "+%m/%d-%T")] [(whoami)@(hostname)]
     echo -n (prompt_pwd) (__fish_git_prompt) '>>'
     set_color normal
end
```


#Lubuntu Package that is safe to remove
```
sudo apt-get remove xpad mtpaint chromium-browser gnome-mplayer audacious guvcview xfburn xterm sylpheed
sudo apt-get autoremove
```


#Lubuntu Recomended Packages
```
sudo apt-get install vlc browser-plugin-vlc
```



#Lubuntu Area Snap Keys:

## Edit the lubuntu settings here
`vim ~/.config/openbox/lubuntu-rc.xml`

## To restart the lubuntu key binding
`openbox --reconfigure`

http://ubuntuforums.org/showthread.php?t=2076433
```
  <!-- Aero Snap for Openbox Begin Code-->
    <keybind key="W-Left">        # HalfLeftScreen
      <action name="UnmaximizeFull"/>
      <action name="MoveResizeTo">
        <x>0</x>
        <y>0</y>
        <height>97%</height>
        <width>50%</width>
      </action>
    </keybind>
    <keybind key="W-Right">        # HalfRightScreen
      <action name="UnmaximizeFull"/>
      <action name="MoveResizeTo">
        <x>-0</x>
        <y>0</y>
        <height>97%</height>
        <width>50%</width>
      </action>
    </keybind>
    <keybind key="W-Up">        # HalfUpperScreen
      <action name="UnmaximizeFull"/>
      <action name="MoveResizeTo">
        <x>0</x>
        <y>0</y>
        <width>100%</width>
        <height>50%</height>
      </action>
    </keybind>
    <keybind key="W-Down">        # HalfLowerScreen
      <action name="UnmaximizeFull"/>
      <action name="MoveResizeTo">
        <x>0</x>
        <y>-0</y>
        <width>100%</width>
        <height>50%</height>
      </action>
    </keybind>
<!-- Aero Snap for Openbox End Code-->
 
```



http://askubuntu.com/questions/79557/bind-the-windows-key-to-lubuntu-start-menu
```
<!-- Aero Snap for Openbox Begin Code-->
<keybind key="Super_L">
  <action name="Execute">
    <command>lxpanelctl menu</command>
  </action>
</keybind>
```
