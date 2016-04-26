#For command line
	#function wget(){
	#	curl -LOk
	#}
	
	
	function br(){
		clear &&  echo $'\e[31m=============================================\e[m' && echo '' && echo ''
	}
	
	
	function searchSource(){
		br;
		echo "Searching:  $1";
		sift --binary-skip --color \
			--exclude-path 'node_modules|bin' \
			--ext html,js,scss,json,java,xml \
			--limit=1 \
			--output-sep="\n\n" \
		    --line-number \
		    --no-zip \
			--err-skip-line-length \
			--output-limit=100 "$1"
	}
	
	function searchSourceIgnoreCase(){
		br;
		echo "Searching [Ignore Case]:  $1";
		sift -i \
			--binary-skip --color \
			--exclude-path 'node_modules|bin' \
			--ext html,js,scss,json,java,xml \
			--limit=2 \
			--output-sep="\n\n" \
		    --line-number \
		    --no-zip \
			--err-skip-line-length \
			--output-limit=100 "$1"
	}
	
	
	function searchFileName(){
		find . -iname "$1"
	}
	
	
	function renpm(){
		rm -Rf node_modules && npm install
	}
	
	
	function tree(){
		find . -type d | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/"
	}
	
	
	#screensaver
	#mac specific
	function s(){
		echo "starting screensaver for mac";
		open -a /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app
	}
	
	
	#case insenstive autocomplete
	echo '#ignore case for autocomplete' > ~/.inputrc
	echo 'set completion-ignore-case on' >> ~/.inputrc
