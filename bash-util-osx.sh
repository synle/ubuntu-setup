#For GUI Distro
export EDITOR='vim'

#################
#mac specific
#################
  export EDITOR='subl -w'
  
  #screensaver
  function s(){
    echo "starting screensaver for mac";
    open -a /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app
  }
  
  
  #sublime text alias
  #alias subl='open -a "Sublime Text"'
#   alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
  
  
  #default java path
  export JAVA_HOME="$(/usr/libexec/java_home)"


##############################
#fzf only apply to mac for now
##############################
  #fzf
  #   https://github.com/junegunn/fzf/wiki/examples
  #fzf file view
  function vv(){
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
  function fd() {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune \
        -o -type d -print 2> /dev/null | filterUnwanted | fzf +m --preview="ls -la {}");
    echo "PWD: $PWD"
    echo "Selected: $dir";
    cd "$dir"
  }


  function fgrep(){
    local OUT
    OUT=$(grep --line-buffered --color=never -r "" * | filterUnwanted | fzf)
    echo $OUT | cut -d ":" -f1 | xargs echo;
    echo $OUT | cut -d ":" -f1 | xargs $EDITOR;
  }


  
  function fh() {
    local OUT;
    OUT=$( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//');
    echo $OUT;
    echo '===='
    eval $OUT
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
  function gshow() {
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

  function gco() {
    local branches branch
    branches=$(git branch --all | grep -v HEAD) &&
    branch=$(echo "$branches" |
         fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
  }

  function gcocommit() {
    local commits commit
    commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
    commit=$(echo "$commits" | fzf --tac +s +m -e) &&
    git checkout $(echo "$commit" | sed "s/ .*//")
  }
