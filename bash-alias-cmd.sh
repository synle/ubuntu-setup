#For command line
export EDITOR='vim'
npm set progress=false;

alias g=git

# aliases

# php composer
alias composer="php ~/composer.phar"

# php silex start
alias startSilex="php -S localhost:8080 -t web web/index.php"

function br(){
    clear &&  echo $'\e[31m=============================================\e[m' && echo '' && echo ''
}

function refreshBashSyLe(){
    echo ">> running refresh scripts"
    curl -H 'Cache-Control: no-cache' -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/makeBashRefresh.sh | bash
    
    # resource home
    echo ">> resource bash profile"
    . ~/.bashrc
}



function removeNodeModules(){
    echo "removed nested node_modules...";
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




# set up inputrc preferences.
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
"\e[Z": "\e-1\C-i"'   
""" >  ~/.inputrc


# 
echo "" >  ~/.inputrc
echo '#ignore case for autocomplete' >> ~/.inputrc
echo 'set completion-ignore-case on' >> ~/.inputrc

# https://gist.github.com/gregorynicholas/1812027
echo 'set expand-tilde on' >> ~/.inputrc
echo 'set show-all-if-ambiguous on' >> ~/.inputrc
echo 'set visible-stats on' >> ~/.inputrc
echo '#set match-hidden-files off' >> ~/.inputrc

# http://hiltmon.com/blog/2013/03/12/better-bash-shell-expansion/
echo '"\e[Z": "\e-1\C-i"'  >> ~/.inputrc # shift tab to reverse auto complete.
