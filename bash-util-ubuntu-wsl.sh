# wsl only alias
alias subl="subl.exe"
alias pbcopy="win32yank -i"
alias pbpaste="win32yank -o"
alias open="explorer.exe"

# for android.
alias adb="adb.exe"
alias fastboot="fastboot.exe"


# path conversion for window
function getAbsolutePathForAllSystem(){
    if [ "$#" = "1" ];
    then
        echo $@ | sed 's/\/mnt\///' | sed 's/\//:\//1'
    else
        sed 's/\/mnt\///' | sed 's/\//:\//1'
    fi
}


# folder where we store all the sublime project
export MY_SUBLIME_PROJECT_PATH=/mnt/c/Users/$(whoami)/.sublime-project
