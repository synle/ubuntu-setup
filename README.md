# Common Bash Util.

## Install & Refresh script
````
# Refresh Script
function curlNoCache(){
    curl -so- -H  'Cache-Control: no-cache' "$@?$(date +%s)"
}
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/makeBashRefresh.sh | bash
```
