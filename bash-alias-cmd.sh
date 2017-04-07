#For command line
export EDITOR='vim'

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
alias g=git
alias composer="php ~/composer.phar" # php composer
alias startSilex="php -S localhost:8080 -t web web/index.php" # php silex start

function br(){
    clear &&  echo $'\e[31m=============================================\e[m' && echo '' && echo ''
}


# print formatted text for easy to read console output.
function echoo(){ printf "\e[1;31m$@\n\e[0m"; }

function curlNoCache(){ curl -s "$@?$(date +%s)"; }

function refreshBashSyLe(){
    echoo "Running refresh scripts"
    curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/makeBashInstall.sh | bash

    # resource bash profile / bash rc
    echo """
============================================================
    """
    echoo "Resource bash profile"
    [ -s ~/.bashrc ] && . ~/.bashrc;
    [ -s ~/.bash_profile ] && . ~/.bash_profile;
}


function openSublimePackageControl(){
    cat ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Package\ Control.sublime-settings;
#     cat ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Package\ Control.sublime-settings;
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
    rm -rf node_modules /tmp/*.cache || npm install
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
function sps() {
    python -c "import sys; dirs = sys.argv[1].split('/'); print '/'.join(d[:1] for d in dirs[:-1]) + '/' + dirs[-1]" $PWD
}

function filterUnwanted(){
    grep -v node_modules \
    | grep -v .cache.js \
    | grep -v .class \
    | grep -v .db \
    | grep -v .dll \
    | grep -v .doc \
    | grep -v .docx \
    | grep -v .DS_Store \
    | grep -v .dylib \
    | grep -v .eslintcache \
    | grep -v .exe \
    | grep -v .git \
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
    | grep -v staticresources.resource
}


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

# set current upstream ref
function setGitUpstreamBranch(){
    git branch -u origin/$(git name-rev --name-only HEAD)
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
    

    # fzf file view
    function fuzzyVim(){
      local OUT=$( find . -type f 2>/dev/null | filterUnwanted | fzf )
      
      if [ "0" == "$?" ] ; then
          echo "vim $OUT";
          vim $OUT
      fi
    }
    
    
    function fuzzyViewFile(){
      local OUT=$( find . -type f 2>/dev/null | filterUnwanted | fzf )
      viewFile $OUT
    }

    # cdf - cd into the directory of the selected file
    function fuzzyDirectory() {
      local dir
      dir=$(find ${1:-.} -path '*/\.*' -prune \
          -o -type d -print 2> /dev/null | filterUnwanted | fzf +m --preview="ls -la {}");
      echo "PWD: $PWD"
      echo "Selected: $dir";
      cd "$dir"
    }


    function fuzzyGrep(){
      local OUT
      OUT=$(grep --line-buffered --color=never -r "" * | filterUnwanted | fzf)
      echo $OUT | cut -d ":" -f1 | xargs echo;
      echo $OUT | cut -d ":" -f1 | xargs $EDITOR;
    }



    function fuzzyHistory() {
      local OUT;
      OUT=$( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//');
      echo $OUT;
      echo '===='
      eval $OUT
    }


    # fkill - kill process
    function fuzzyKill() {
      pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

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
    
    
    function fuzzyMakeComponent(){
        makeComponentCommand=$(make-help | sed '/^\s*$/d' | fzf)
        echo "$makeComponentCommand"
        $makeComponentCommand
    }

############################################
#############  SECTION BREAK  ##############
############################################


############################################
# awesome keybinding
############################################

# ctrl p to fvim
bind '"\C-p":"fviewfile\r"'

# ctrl n to view make new component options
bind '"\C-n":"fuzzyMakeComponent\r"'


############################################
#############  SECTION BREAK  ##############
############################################
