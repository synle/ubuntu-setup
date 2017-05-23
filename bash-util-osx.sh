#MAC only stuffs
#random background color
# COLOR=""
# for X in 1 2 3 4 5 6 ; do
#   COLOR=$COLOR`expr $RANDOM % 3`
# done
# echo -e -n "\033]Ph${COLOR}\033\\"



#bind tab to switch connection.
bind '"\t":menu-complete'


#################
#mac specific
#################
export EDITOR='subl'

#reset / kill Dock (caused by thunderbolt display
function kd(){
  killall Dock
}

#screensaver
function s(){
  echo "starting screensaver for mac";
  open -a /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app
}


#sublime text alias
alias subl1='open -a "Sublime Text"'
alias subl2="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias subl="subl2"


#default java path
export JAVA_HOME="$(/usr/libexec/java_home)"
