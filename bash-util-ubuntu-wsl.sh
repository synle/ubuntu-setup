# wsl only alias
alias open="explorer.exe"
alias subl="subl.exe

# for android.
alias adb="adb.exe"
alias fastboot="fastboot.exe"


# path conversion for window
function getAbsolutePathForAllSystem(){
    if [ "$#" = "1" ];
    then
        # data is passed in
        echo $@ | sed 's/\/mnt\///' | sed 's/\//:\//1'
    else
        # handled via pipe
        sed 's/\/mnt\///' | sed 's/\//:\//1'
    fi
}


# folder where we store all the sublime project
export MY_SUBLIME_PROJECT_PATH=/mnt/c/Users/$(whoami)/.sublime-project
