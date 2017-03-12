#!/usr/bin/env bash
#################################
# script begins....
# install script starts here...
#################################
function curlNoCache(){
    curl -so- -H 'Cache-Control: no-cache' "$@?$(date +%s)"
}

echo "Refresh (idempotent)"
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/makeBashRefresh.sh | bash -
