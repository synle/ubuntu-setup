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
    sed 's/\/mnt\///' | sed 's/\//:\//1'
}
