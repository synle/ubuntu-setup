#For command line
	#function wget(){
	#	curl -LOk
	#}
	
	
	function br(){
		clear &&  echo $'\e[31m=============================================\e[m' && echo '' && echo ''
	}
	
	
	function searchSource(){
		#universal option
		grep -r "$@" \
			--include=*.js --include=*.html --include=*.scss --include=*.java --include=*.json \
			. \
			| grep -v node_modules/ \
			| grep -v release/

		#option 2
		#git grep "$@";
		
		
		# option 1
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
	
	function stopAllNodeProcesses(){
		echo "Stopping all node processes";
		ps aux | grep node | awk '{ print $2 }' | xargs kill;
		#ps aux | grep node | grep -v tsserver | grep -v Adobe | awk '{ print $2 }' | xargs kill;
		#ps wwax | grep -E '[s]tart-server|[i]qb' | awk '{ print $1 }' | xargs kill;
	}
	
	function getIpAddrress(){
		ifconfig | grep "10\.\|192\." | awk '{ print $2}'
		# ifconfig | grep "10\.\|192\." | awk '{ print $2}' | tr '\n' '\t'
	}
	
	
	#awesome git commands
	#config
	git config --global user.name "Sy Le"
	
	#git alias
	git config --global alias.del-merged-branches "!git branch --merged | grep -v '*' | xargs git branch -d"
	git config --global alias.unstage 'reset HEAD --'
	git config --global alias.co 'checkout'
	git config --global alias.cp 'cherry-pick'
	git config --global alias.cm 'commit'
	git config --global alias.del 'branch -D'
	git config --global alias.br 'branch -v'
	git config --global alias.b  'branch -v'
	git config --global alias.p 'push'
	git config --global alias.logs 'log --oneline --decorate'
	git config --global alias.fap 'fetch --all --prune'
	git config --global alias.st 'status -sb'
	git config --global alias.amend 'commit --amend'
	#end git
	
	
	#short path
	sps() {                                                                                              
	    python -c "import sys; dirs = sys.argv[1].split('/'); print '/'.join(d[:1] for d in dirs[:-1]) + '/' + dirs[-1]" $PWD
	}
	
	#case insenstive autocomplete
	echo "" >  ~/.inputrc
	echo '#ignore case for autocomplete' >> ~/.inputrc
	echo 'set completion-ignore-case on' >> ~/.inputrc

	#https://gist.github.com/gregorynicholas/1812027
	echo 'set expand-tilde on' >> ~/.inputrc
	echo 'set show-all-if-ambiguous on' >> ~/.inputrc
	echo 'set visible-stats on' >> ~/.inputrc
	echo '#set match-hidden-files off' >> ~/.inputrc
	
	#http://hiltmon.com/blog/2013/03/12/better-bash-shell-expansion/
	echo '"\e[Z": "\e-1\C-i"'  >> ~/.inputrc # shift tab to reverse auto complete.
