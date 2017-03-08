#For command line
export EDITOR='vim'
npm set progress=false;

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

# php composer
alias composer="php ~/composer.phar"

# php silex start
alias startSilex="php -S localhost:8080 -t web web/index.php"

function br(){
    clear &&  echo $'\e[31m=============================================\e[m' && echo '' && echo ''
}


# print formatted text for easy to read console output.
function echoo(){
    printf "\e[1;4;33m>> $@ \n\e[0m"
}

function refreshBashSyLe(){
    echoo "Running refresh scripts"
    curl -H 'Cache-Control: no-cache' -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/makeBashRefresh.sh | bash
    
    # resource bash profile / bash rc
    echoo "Resource bash profile"
    [ -s ~/.bashrc ] && . ~/.bashrc;
    [ -s ~/.bash_profile ] && . ~/.bash_profile;
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
    | grep -v release/ \
    | grep -v .DS_Store \
    | grep -v .git \
    | grep -v .sass-cache
}


function compareGit(){
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
############################################
#############  SECTION BREAK  ##############
############################################



############################################
# fzf - fuzzy find
# fzf only apply to mac for now
# https://github.com/junegunn/fzf/wiki/examples
# 
# for now this is only applied to Mac and Ubuntu
############################################
is_os_window=0
[ -d /mnt/c/Users ] && is_os_window=1
if [ $is_os_window == "0" ]
then
    # fzf file view
    function fuzzyvim(){
      local OUT
      local QUERY

      QUERY=""
      if [ "$1" != "" ] ; then
          QUERY=" -1 --query=$1"
      fi

      OUT=$( find . | filterUnwanted | fzf $QUERY --preview="cat {}" )
      if [ "0" == "$?" ] ; then
          echo "$EDITOR $OUT";
          $EDITOR $OUT
      else
          echo "Aborting..."
      fi
    }

    # cdf - cd into the directory of the selected file
    function fuzzydirectory() {
      local dir
      dir=$(find ${1:-.} -path '*/\.*' -prune \
          -o -type d -print 2> /dev/null | filterUnwanted | fzf +m --preview="ls -la {}");
      echo "PWD: $PWD"
      echo "Selected: $dir";
      cd "$dir"
    }


    function fuzzygrep(){
      local OUT
      OUT=$(grep --line-buffered --color=never -r "" * | filterUnwanted | fzf)
      echo $OUT | cut -d ":" -f1 | xargs echo;
      echo $OUT | cut -d ":" -f1 | xargs $EDITOR;
    }



    function fuzzyhistory() {
      local OUT;
      OUT=$( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//');
      echo $OUT;
      echo '===='
      eval $OUT
    }


    # fkill - kill process
    function fuzzykill() {
      pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

      if [ "x$pid" != "x" ]
      then
        kill -${1:-9} $pid
      fi
    }


    #fuzzy git
    function fuzzygitshow() {
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

    function fuzzygitcobranch() {
      local branches branch
      branches=$(git branch --all | grep -v HEAD) &&
      branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
      git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
    }

    function fuzzygitcocommit() {
      local commits commit
      commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
      commit=$(echo "$commits" | fzf --tac +s +m -e) &&
      git checkout $(echo "$commit" | sed "s/ .*//")
    }
fi
############################################
#############  SECTION BREAK  ##############
############################################
