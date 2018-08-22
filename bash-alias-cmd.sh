#For command line
export EDITOR='vim'

# os flags
is_os_darwin_mac=0
is_os_ubuntu=0
is_os_redhat=0
is_os_window=0
[ -d /Library ] && is_os_darwin_mac=1
[ -d /mnt/c/Users ] && is_os_window=1
apt-get -v &> /dev/null && is_os_ubuntu=1
yum -v &> /dev/null && is_os_redhat=1

############################################
# input rc preferences
# set up inputrc preferences.
############################################
#case insenstive autocomplete
echo """
# case insenstive autocomplete
# ignore case for autocomplete'
set completion-ignore-case on'
# https://gist.github.com/gregorynicholas/1812027
set expand-tilde on'
set show-all-if-ambiguous on'
set visible-stats on'
#set match-hidden-files off'
# http://hiltmon.com/blog/2013/03/12/better-bash-shell-expansion/
# shift tab to reverse auto complete.
""" >  ~/.inputrc
echo '"\e[Z": "\e-1\C-i"'  >> ~/.inputrc
############################################
#############  SECTION BREAK  ##############
############################################





############################################
# aliases & function
############################################
alias ..="cd .."
alias ls="ls -1"
alias composer="php ~/composer.phar" # php composer
alias startSilex="php -S localhost:8080 -t web web/index.php" # php silex start
alias g=git
__git_complete g _git #auto complete for git with this short hand g

function br(){
    clear &&  echo $'\e[31m=============================================\e[m' && echo '' && echo ''
}

# this get support path for all system (mainly support for wsl)
function getAbsolutePathForAllSystem(){
    # temporary make this a empty method for support in unix
    # empty function
    :
}

# sublime tricks
export MY_SUBLIME_PROJECT_PATH=~/.sublime_project

# open sublime project with fzf (fuzzy find)
function subl-open-project(){
    mySublimeProjectFriendlyPath="$(getAbsolutePathForAllSystem $MY_SUBLIME_PROJECT_PATH)"
    myProjectPath="$mySublimeProjectFriendlyPath/$(ls $MY_SUBLIME_PROJECT_PATH | grep sublime-project| fzf)"
    
    # running the command
    echo "subl $myProjectPath"
    subl $myProjectPath
}

############
# Usage
# Pass a path to watch, a file filter, and a command to run when those files are updated
#
# Example:
# watch.sh "node_modules/everest-*/src/templates" "*.handlebars" "ynpm compile-templates"
#
# Source: https://gist.github.com/JarredMack/b33900d64c0e448fd5ff1e1bd760789e
############
watch() {
    WORKING_PATH=$(pwd)
    DIR=$1
    FILTER=$2
    COMMAND=$3
    chsum1=""

    while [[ true ]]
    do
        chsum2=$(find -L $WORKING_PATH/$DIR -type f -name "$FILTER" -exec md5 {} \;)
        if [[ $chsum1 != $chsum2 ]] ; then
            echo "Found a file change, executing $COMMAND..."
            $COMMAND
            chsum1=$chsum2
        fi
        sleep 2
    done
}


# calculate chmod
function chmod-calculator(){
	node -e """
		console.log('Chmod Calculator');
		console.log('Nginx: r-x: 101: 5');
		console.log('Enter permission for xwr:');

		var stdin = process.openStdin();

		stdin.addListener('data', function(d) {
			const str = d.toString().trim();

			console.log('value:');
			console.log(_getValue.apply(null, [...str]))

			process.exit();
		});

		function _getValue(x, w, r){
			var val = 0;
			if(x === true || x + '' === '1'){ val += 1; }
			if(w === true || w + '' === '1'){ val += 2; }
			if(r === true || r + '' === '1'){ val += 4; }
			return val;
		};
	"""
}

# bootstrap new sublime project
function subl-new-project(){
    # make the folder if needed
    mkdir -p $MY_SUBLIME_PROJECT_PATH
    
    #default filename
    defaultProjectName="${PWD##*/}"
    
    echo -n "Enter Project Name ($defaultProjectName):"
    read myProjectName


    if [ -z "$myProjectName" ];
    then
        # get the current dir name
        myProjectName=$defaultProjectName
    fi
    
    
    echo '''
    {
        "folders":
        [
            {
                "path": "NEW_PROJECT_PATH",
                "follow_symlinks": true,
                "file_exclude_patterns":
                [
                    "npm-debug.log",
                    "*.dll"
                ]
            }
        ],
        "settings":
        {
            "tab_size": 4
        },
        "build_systems":
        [
            {
                "working_dir": "${file_path}",
                "name": "Build My Project",
                "shell_cmd": "ls",
                "windows" :
                {
                    "shell_cmd": "bash -c \"ls\""
                }
            }
        ]
    }
    ''' \
    | awk '{gsub("NEW_PROJECT_PATH", myFolder, $0); print}' myFolder="$(pwd | getAbsolutePathForAllSystem)" \
    > "$MY_SUBLIME_PROJECT_PATH/$myProjectName.sublime-project"
    
    echo "Open New Sublime Project by:"
    echo "subl $MY_SUBLIME_PROJECT_PATH/$myProjectName.sublime-project" | getAbsolutePathForAllSystem
}

function subl-new-project-clean(){
    #default filename
    myProjectName="${PWD##*/}"
    
    echo '''
    {
        "folders":
        [
            {
                "path": ".",
                "follow_symlinks": true,
                "file_exclude_patterns":
                [
                    "npm-debug.log",
                    "*.dll"
                ]
            }
        ],
        "settings":
        {
            "tab_size": 4
        },
        "build_systems":
        [
            {
                "working_dir": "${project_path}",
                "name": "Build My Project",
                "shell_cmd": "ls",
                "windows" :
                {
                    "shell_cmd": "bash -c \"ls\""
                }
            }
        ]
    }
    ''' \
    > "$myProjectName.sublime-project"
    
    echo "Open New Sublime Project by:"
    echo "subl $myProjectName.sublime-project" | getAbsolutePathForAllSystem
}

function port-forwarding(){
    echo "ssh -L 8080:localhost:8080 my-awesome-host"
}

# print formatted text for easy to read console output.
function echoo(){ printf "\e[1;31m$@\n\e[0m"; }

function curlNoCache(){ curl -s "$@?$(date +%s)"; }

function refreshBashSyLe(){
    echoo "Running refresh scripts"
#     sudo apt-get update -y;
    curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/makeBashInstall.sh | bash

    # resource bash profile / bash rc
    echo """
============================================================
    """
    echoo "Resource bash profile"
    [ -s ~/.bashrc ] && . ~/.bashrc;
    [ -s ~/.bash_profile ] && . ~/.bash_profile;
}


function startHttpServer(){ 
    http-server --cors 
}

function openSublimePackageControl(){
    cat ~/Library/Application*/Sublime*/Packages/User/Package*Control.sublime-settings;
    cat /mnt/c/Users/*/AppData/Roaming/Sublime*/Packages/User/Package*Control.sublime-settings
}


# check if a command exists
# if isCommandExists subl ; then
#     alias editorCmd=subl
# fi
function isCommandExists () {
    type "$1" &> /dev/null ;
}


function removeNodeModules(){
    echoo "Removed nested node_modules...";
    find . | grep node_modules | xargs rm -rf > /dev/null
}

function searchSource(){
    #universal option
    grep -r "$@" \
        --include=*.js --include=*.html --include=*.scss --include=*.java --include=*.json \
        . \
        | filterUnwanted

    #option 2
    #git grep "$@";


    # option 1
    # br;
    # echo "Searching:  $@";
    # sift --binary-skip --color \
    #   --exclude-path 'node_modules|bin' \
    #   --ext html,js,scss,json,java,xml \
    #   --limit=1 \
    #   --output-sep="\n\n" \f
    #     --line-number \
    #     --no-zip \
    #   --err-skip-line-length \
    #   --output-limit=100 "$@"
}


function searchFileName(){
    find . -type f -iname "*$@*" | grep -v node_modules | grep --color -i "$@"
}


function renpm(){
    rm -rf node_modules bower_components /tmp/*.cache;
    npm install
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
    echoo "Stopping all node processes";
    ps aux | grep node | grep /git | awk '{ print $2 }' | xargs kill;
    # ps aux | grep node | grep -v tsserver | grep -v Adobe | awk '{ print $2 }' | xargs kill;
    # ps wwax | grep -E '[s]tart-server|[i]qb' | awk '{ print $1 }' | xargs kill;
}

function stopAllPythonProcesses(){
    echoo "Stopping all python processes"
    ps aux | grep python | grep /git | awk '{ print $2 }' | xargs kill;
}

function createSelfSignedCertificate(){
    echoo "creating self signed certificate"
    echo """
    https://stackoverflow.com/questions/10175812/how-to-create-a-self-signed-certificate-with-openssl
    https://github.com/synle/node-proxy-example
    https://askubuntu.com/questions/73287/how-do-i-install-a-root-certificate
    """
    
    echo "====="
    echo """
    # pem
    openssl genrsa -out key.pem
    openssl req -new -key key.pem -out csr.pem
    openssl x509 -req -days 9999 -in csr.pem -signkey key.pem -out cert.pem
    rm csr.pem

    # pem to crt
    openssl x509 -in cert.pem -inform PEM -out cert.crt

    # accept crt in ubuntu
    sudo cp cert.crt /usr/local/share/ca-certificates/localhost-com.crt
    """
}

function getIpAddrress(){
    ifconfig | grep "10\.\|192\." | awk '{ print $2}'
    # ifconfig | grep "10\.\|192\." | awk '{ print $2}' | tr '\n' '\t'
}


# set up express project
function new-express-project(){
    express -H --css less --git --force
}

function getIpAddress(){
    ifconfig eth| grep "inet" | awk '{print $2}' | sed 's/[^0-9.]*//g'
}

function filterUnwanted(){
    filterUnwantedLight \
    | grep -v .cache.js \
    | grep -v .class \
    | grep -v .db \
    | grep -v .dll \
    | grep -v .doc \
    | grep -v .docx \
    | grep -v .dylib \
    | grep -v .eslintcache \
    | grep -v .exe \
    | grep -v .idb \
    | grep -v .jar \
    | grep -v .jpg \
    | grep -v .js.map \
    | grep -v .lib \
    | grep -v .min.js \
    | grep -v .mp3 \
    | grep -v .ncb \
    | grep -v .obj \
    | grep -v .ogg \
    | grep -v .pdb \
    | grep -v .pdf \
    | grep -v .pid \
    | grep -v .pid.lock \
    | grep -v .png \
    | grep -v .psd \
    | grep -v .pyc \
    | grep -v .pyo \
    | grep -v .sass-cache \
    | grep -v .sdf \
    | grep -v .seed \
    | grep -v .so \
    | grep -v .sublime-project \
    | grep -v .sublime-workspace \
    | grep -v .suo \
    | grep -v .swf \
    | grep -v .swp \
    | grep -v .zip \
    | grep -v corsWhitelistOrigins.resource \
    | grep -v npm-debug.log \
    | grep -v remoteSiteSettings.resource \
    | grep -v staticresources.resource \
    | uniq
}

function filterUnwantedLight(){
    grep -v .DS_Store \
        | grep -v .git \
        | grep -v node_modules \
        | uniq
}

alias ll="ls -la | filterUnwantedLight"


function gitCompare(){
    #get current branch name
    branch_name=$(git symbolic-ref -q HEAD)
    branch_name=${branch_name##refs/heads/}
    branch_name=${branch_name:-HEAD}

    #get current project name
    project_name=$(git rev-parse --show-toplevel);
    project_name=${project_name##*/}

    #get current repo name
    repo_name=$(git config --get remote.origin.url)
    repo_name=${repo_name#*:}
    repo_name=${repo_name/.git/}


    baseSha1=${2-staging}
    baseSha2=${1-$branch_name}

    urlToShow=https://github.com/${repo_name}/compare/${baseSha1}...${baseSha2}
    echo $urlToShow

    if hash open 2>/dev/null; then
        open $urlToShow
    fi
}

# get current git branch name
function getCurrentGitBranch(){
    git name-rev --name-only HEAD
}

function getCurrentGitRepo(){
	basename `git rev-parse --show-toplevel`
}

# set current upstream ref
function setGitUpstreamBranch(){
    git branch -u origin/$(git name-rev --name-only HEAD)
}


function removeFileFromGitHistory(){
    git filter-branch --force --index-filter \
    'git rm -r --cached --ignore-unmatch $@' \
    --prune-empty --tag-name-filter cat -- --all
}


function ifconfig2(){
	node -e """
	require('dns').lookup(require('os').hostname(), function (err, add, fam) {
		console.log(add);
	})
	""";
}


#alias gitOpen="echo `git remote -v | grep fetch | awk '{print $2}' | sed 's/git@/http:\/\//' | sed 's/com:/com\//'`| head -n1"

# rebase
function rebase-repo(){
    pushd $@
    git fetch --all --prune
    git rebase
    popd
}

############################################
#############  SECTION BREAK  ##############
############################################



############################################
# aliases & function for WORK
############################################
function startSfdcAura(){
  mvn jetty:start -Djetty.port=9090 -Dwebdriver.browser.type=GOOGLECHROME
}

function createReviewForCollabEdit(){
  ccollab addgitdiffs new HEAD^
}

function compileSfdcAuraQuick(){
  mvn clean install -DskipUnitTests -DskipJsDoc
}
############################################
#############  SECTION BREAK  ##############
############################################


############################################
# fzf - fuzzy find
# fzf only apply to mac for now
# https://github.com/junegunn/fzf/wiki/examples
############################################
    alias fvim=fuzzyVim
    alias fviewfile=fuzzyViewFile
    alias fsubl=fuzzySublime
    alias fcd=fuzzyDirectory
    alias fgrep=fuzzyGrep
    alias fhistory=fuzzyHistory
    alias fhist=fhistory
    alias fkill=fuzzyKill    
    alias glog=fuzzyGitShow
    alias gco=fuzzyGitCobranch
    alias gbranch=fuzzyGitBranch
    alias glog=fuzzyGitLog
    
    function viewFile(){
        local editorCmd

        if [[ $# -eq 0 ]] ; then
            return 1 # silent exit
        fi

        if isCommandExists subl.exe ; then
            # wsl mode
            editorCmd=subl.exe
        elif isCommandExists subl ; then
            # mac or other linux
            editorCmd=subl
        else
            # no subl, fall back to vim
            editorCmd=vim;
        fi

        echo "viewFile $@"
        $editorCmd $@
    }
    
    function listDirsInPwd(){
        find ${1:-.} -path '*/\.*' -prune \
              -o -type d -print 2> /dev/null
        echo ".." # append parent folder
    }
    
    function listFilesInPwd(){
        # use either ls tree or find
        git ls-tree -r --name-only HEAD 2> /dev/null || \
        find . -type f 2>/dev/null
    }
    
    function printFullPath(){
        echo $@
    }
    

    # fzf file view
    function fuzzyVim(){
      local OUT=$( listFilesInPwd | filterUnwanted | fzf )
      
      if [ "0" == "$?" ] ; then
          echo "vim $OUT";
          vim $OUT
      fi
    }
    
    
    function fuzzyViewFile(){
      local OUT=$( listFilesInPwd | filterUnwanted | fzf )
      viewFile $OUT
    }

    # cdf - cd into the directory of the selected file
    function fuzzyDirectory() {
      local dir=$(listDirsInPwd | \
          filterUnwanted | \
          fzf +m);
      echo "PWD: $PWD"
      printFullPath $dir;
      cd "$dir"
    }


    function fuzzyGrep(){
      local OUT
      OUT=$(grep --line-buffered --color=never -r "" * | filterUnwanted | fzf | cut -d ":" -f1)
      viewFile $OUT
    }



    function fuzzyHistory() {
      local OUT=$( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//');
      echo $OUT;
      echo '===='
      eval $OUT
    }


    # fkill - kill process
    function fuzzyKill() {
      local pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

      if [ "x$pid" != "x" ]
      then
        kill -${1:-9} $pid
      fi
    }


    #fuzzy git
    function fuzzyGitShow() {
      # git log --pretty=format:'%Cred%h%Creset %s %Cgreen%cr %C(bold blue)%an%Creset' --abbrev-commit --date=relative --color=always \
      git log --pretty=format:'%Cred%h%Creset %s %C(bold blue)%an%Creset' --abbrev-commit --date=relative --color=always \
      |
      fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort --color light --preview='echo {} | cut -d " " -f1 | xargs git show' \
      --bind "ctrl-m:execute:
      (grep -o '[a-f0-9]\{7\}' | head -1 |
      xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
      {}
      FZF-EOF"
    }

    
    function fuzzyGitCobranch() {
      local branches branch
      branches=$(git branch --all | grep -v HEAD | sed 's/remotes\/origin\///g' | sed "s/.* //" | sed 's/ //g' | sed "s#remotes/[^/]*/##" | sort | uniq) &&
      branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
      git checkout $(echo "$branch")
    }
    
    
    function fuzzyGitBranch() {
      local branches branch
      branches=$(git branch --all | grep -v HEAD | sed 's/remotes\/origin\///g' | sed "s/.* //" | sed 's/ //g' | sed "s#remotes/[^/]*/##" | sort | uniq) &&
      branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
      echo "git checkout $branch"
    }


    function fuzzyGitCocommit() {
      local commits commit
      commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
      commit=$(echo "$commits" | fzf --tac +s +m -e) &&
      git checkout $(echo "$commit" | sed "s/ .*//")
    }
    
    
    function fuzzyGitLog() {
      local commits commit
      commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
      commit=$(echo "$commits" | fzf --tac +s +m -e) &&
      echo "git show $(echo "$commit" | sed "s/ .*//")"
    }
    
    
    function getMakeComponentOptions(){
        make-help
    }

    function getCommandFromBookmark(){
        cat ~/.syle_bookmark
    }
    
    function addCommandToBookmarks(){
        echo $@ >> ~/.syle_bookmark
        echo "Bookmarking '"$@"'"
        removeDuplicateLines ~/.syle_bookmark > /tmp/syle-bookmark-temp
        cat /tmp/syle-bookmark-temp > ~/.syle_bookmark
        
        # remove the temp file
        rm /tmp/syle-bookmark-temp
    }
    
    function removeDuplicateLines(){
        perl -ne 'print unless $dup{$_}++;' $@
    }

    function fuzzyMakeComponent(){
        makeComponentCommand=$(( \
            getMakeComponentOptions \
            ) | sed '/^\s*$/d' | uniq | fzf)
        echo "$makeComponentCommand"
        $makeComponentCommand
    }


    function fuzzyFavoriteCommand(){
        makeComponentCommand=$(( \
            getCommandFromBookmark
            ) | sed '/^\s*$/d' | uniq | fzf)
        echo "$makeComponentCommand"
        
        # run the command
        $makeComponentCommand
        
        # put the command into history
        history -s "$makeComponentCommand"
    }

    

    
    
    # allow default fzf completion for node and subl
#     complete -F _fzf_path_completion node
#     complete -F _fzf_path_completion subl

    # different completion trigger
    export FZF_COMPLETION_TRIGGER='*'

    # If you're running fzf in a large git repository, git ls-tree can boost up the speed of the traversal.
    export FZF_DEFAULT_COMMAND='
      (git ls-tree -r --name-only HEAD ||
       find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
          sed s/^..//) 2> /dev/null |\
          filterUnwanted'


############################################
#############  SECTION BREAK  ##############
############################################

# function port-forwarding(){
#     echo "ssh -L 8080:localhost:8080 my-awesome-host"
# }

############################################
# awesome keybinding
############################################

# ctrl p and alt p binding
#bind '"\C-p":"fcd\r"'
#bind '"\ep":"fviewfile\r"'
bind '"\C-o":"fcd\r"'
bind '"\C-p":"fviewfile\r"'
bind '"\C-b":"fuzzyFavoriteCommand\r"'


# ctrl alt p to open sublime project
bind '"\e\C-p":"subl-open-project\r"'

# ctrl n to view make new component options
bind '"\C-n":"fuzzyMakeComponent\r"'


############################################
#############  SECTION BREAK  ##############
############################################
