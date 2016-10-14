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
		# 	--output-sep="\n\n" \f
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
	
	
	# set up express project 
	function new-express-project(){
		express -H --css less --git --force
	}
	
	
	#short path
	sps() {                                                                                              
	    python -c "import sys; dirs = sys.argv[1].split('/'); print '/'.join(d[:1] for d in dirs[:-1]) + '/' + dirs[-1]" $PWD
	}
	
	
	
	#fzf
# 	https://github.com/junegunn/fzf/wiki/examples
#	fd - cd to selected directory
# 	function fd() {
# 	  local dir
# 	  dir=$(find ${1:-.} -path '*/\.*' -prune \
# 			  -o -type d -print 2> /dev/null | fzf +m) &&
# 	  cd "$dir"
# 	}
	#fzf file view
	function vv(){
		QUERY=""
		if [ "$1" != "" ] ; then
		    QUERY=" -1 --query=$1"
		fi

		OUT=$( fzf $QUERY --preview="cat {}" )
		if [ "0" == "$?" ] ; then
		    echo Selected: $OUT
		    vim $OUT
		else
		    echo "Aborting..."
		fi

	}
	
	# cdf - cd into the directory of the selected file
	function fd() {
	  local dir
	  dir=$(find ${1:-.} -path '*/\.*' -prune \
			  -o -type d -print 2> /dev/null | fzf +m --preview="ls -la {}") &&
	  cd "$dir"
	}

	
	function fgrep(){
		grep --line-buffered --color=never -r "" * | fzf
		# with ag - respects .agignore and .gitignore
# 		ag --nobreak --nonumbers --noheading . | fzf
	}
	
	
	function fh() {
	  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
	}
	
	# fkill - kill process
	function fkill() {
	  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

	  if [ "x$pid" != "x" ]
	  then
	    kill -${1:-9} $pid
	  fi
	}
	
	
	#fuzzy git
	function gco() {
	  local branches branch
	  branches=$(git branch --all | grep -v HEAD) &&
	  branch=$(echo "$branches" |
		   fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
	  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
	}
	
	function gshow2() {
		git log --graph --color=always \
		--format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
		fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
		--bind "ctrl-m:execute:
			(grep -o '[a-f0-9]\{7\}' | head -1 |
			xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
			{}
		FZF-EOF"
	}
	
	
	function gshow() {
	    git log --pretty=format:'%Cred%h%Creset %s %Cgreen%cr %C(bold blue)%an%Creset' --abbrev-commit --date=relative --color=always \
	    |
	    fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
	    --bind "ctrl-m:execute:
		(grep -o '[a-f0-9]\{7\}' | head -1 |
		xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
		{}
	    FZF-EOF"
	}

	
	
	function gcocommit() {
		local commits commit
		commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
		commit=$(echo "$commits" | fzf --tac +s +m -e) &&
		git checkout $(echo "$commit" | sed "s/ .*//")
	}
	
	
	# Another CTRL-R script to insert the selected command from history into the command line/region
	builtin set -o histexpand;
	builtin bind -x '"\C-x1": fz';
	builtin bind '"\C-r": "\C-x1\e^\er"'

	
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
