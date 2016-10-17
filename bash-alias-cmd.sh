#For command line
#function wget(){
#   curl -LOk
#}

function br(){
    clear &&  echo $'\e[31m=============================================\e[m' && echo '' && echo ''
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
    rm -rf node_modules && rm -rf /tmp/*.cache && npm install
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


# function viewSubl(){
#     echo "Opening: $@"
#     $EDITOR $@
# }

function filterUnwanted(){
    grep -v node_modules \
    | grep -v /release/ \
    | grep -v .DS_Store \
    | grep -v .git \
    | grep -v .sass-cache
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

#bind tab to switch connection.
bind '"\t":menu-complete'
