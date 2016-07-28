#For command line
	#function wget(){
	#	curl -LOk
	#}
	
	
	function br(){
		clear &&  echo $'\e[31m=============================================\e[m' && echo '' && echo ''
	}
	
	
	function searchSource(){
		git grep "$@";
		# br;
		# echo "Searching:  $@";
		# sift --binary-skip --color \
		# 	--exclude-path 'node_modules|bin' \
		# 	--ext html,js,scss,json,java,xml \
		# 	--limit=1 \
		# 	--output-sep="\n\n" \
		#     --line-number \
		#     --no-zip \
		# 	--err-skip-line-length \
		# 	--output-limit=100 "$@"
	}
	
	
	function searchFileName(){
		find . -type f -iname "*$@*" | grep -v node_modules | grep --color -i "$@"
	}
	
	
	function renpm(){
		rm -Rf node_modules && npm install
	}
	
	
	function tree(){
		find . -type d | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/"
	}
	
	
	function listPort(){
		echo "list port $@"
		lsof -i tcp:$@
	}
	
	function killAllNode(){
		killall -9 node
	}
	
	
	#random background color
	function randomBgColor(){
		COLOR=""
		for X in 1 2 3 4 5 6 ; do
		    COLOR=$COLOR`expr $RANDOM % 3`
		done
		echo -e -n "\033]Ph${COLOR}\033\\"
	}
	
	#case insenstive autocomplete
	touch ~/.inputrc
	echo '#ignore case for autocomplete' >> ~/.inputrc
	echo 'set completion-ignore-case on' >> ~/.inputrc
