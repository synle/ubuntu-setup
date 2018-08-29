##################################################################
# begin prep work #
##################################################################
BASH_SYLE=~/.bash_syle
TEMP_BASH_SYLE=/tmp/.bash_syle
BASH_PATH=~/.bashrc

# os flags
is_os_darwin_mac=0
is_os_ubuntu=0
is_os_redhat=0
is_os_window=0
[ -d /Library ] && is_os_darwin_mac=1
[ -d /mnt/c/Users ] && is_os_window=1
apt-get -v &> /dev/null && is_os_ubuntu=1
yum -v &> /dev/null && is_os_redhat=1

# prep works...
# go to home and start
cd ~

# common functions
function curlNoCache(){ curl -s "$@?$(date +%s)"; }
function echoo(){ printf "\e[1;31m$@\n\e[0m"; }
##################################################################
# end prep work #
##################################################################

##################################################################
#### Core bash prompt ####
##################################################################
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/makeBashPromptMinimal.sh | bash -


##################################################################
#### Extra Stuffs ####
##################################################################
# nvm, node and npm
echo "nvm & node & npm modules"
NVM_BASE_PATH=~/.nvm
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.nvm.node.sh | bash -
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.npm.node.sh | bash -



