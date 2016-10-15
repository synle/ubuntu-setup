#For GUI Distro
export EDITOR='vim'

#mac specific
if [ "$(uname)" == "Darwin" ]; then
	export EDITOR='subl -w'
	
	#screensaver
	function s(){
		echo "starting screensaver for mac";
		open -a /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app
	}
	
	
	#sublime text alias
	#alias subl='open -a "Sublime Text"'
	alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
	
	
	#default java path
	export JAVA_HOME="$(/usr/libexec/java_home)"
	
	#bind tab to switch connection.
	bind '"\t":menu-complete'
fi
