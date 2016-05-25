#For command line
	#function wget(){
	#	curl -LOk
	#}
	
	
	function br(){
		clear &&  echo $'\e[31m=============================================\e[m' && echo '' && echo ''
	}
	
	
	function searchSource(){
		br;
		echo "Searching:  $@";
		sift --binary-skip --color \
			--exclude-path 'node_modules|bin' \
			--ext html,js,scss,json,java,xml \
			--limit=1 \
			--output-sep="\n\n" \
		    --line-number \
		    --no-zip \
			--err-skip-line-length \
			--output-limit=100 "$@"
	}
	
	function searchSourceIgnoreCase(){
		br;
		echo "Searching [Ignore Case]:  $@";
		sift -i \
			--binary-skip --color \
			--exclude-path 'node_modules|bin' \
			--ext html,js,scss,json,java,xml \
			--limit=2 \
			--output-sep="\n\n" \
		    --line-number \
		    --no-zip \
			--err-skip-line-length \
			--output-limit=100 "$@"
	}
	
	
	function searchFileName(){
		find . -type f -iname "*$@*" | grep -v node_modules | grep --color '$@'
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
	
	
	#case insenstive autocomplete
	echo '#ignore case for autocomplete' > ~/.inputrc
	echo 'set completion-ignore-case on' >> ~/.inputrc
