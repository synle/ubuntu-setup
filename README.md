function curlNoCache(){
    curl -so- -H  'Cache-Control: no-cache' "$@?$(date +%s)"
}


# Common Bash Util.

#Installation
```
# init Script : Set it up in .bashrc (run once only)
function curlNoCache(){
    curl -so- -H  'Cache-Control: no-cache' "$@?$(date +%s)"
}
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/makeBashInstall.sh | bash

# Refresh Script
function curlNoCache(){
    curl -so- -H  'Cache-Control: no-cache' "$@?$(date +%s)"
}
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/makeBashRefresh.sh | bash
```
