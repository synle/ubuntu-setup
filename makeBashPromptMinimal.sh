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


# bootstrap if needed
echoo "Install .bash_syle if needed"
grep -q -F '.bash_syle' $BASH_PATH || echo  """
# syle bash
[ -s $BASH_SYLE ] && . $BASH_SYLE
""" >> $BASH_PATH


### start bash-syle
echo  "#!/bin/bash" >> $TEMP_BASH_SYLE
echo '# begin syle bash' > $TEMP_BASH_SYLE

# bash completion
echo  "# Bash Completion - git" >> $TEMP_BASH_SYLE
curlNoCache https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash >> $TEMP_BASH_SYLE
echo  "# Bash Completion - npm" >> $TEMP_BASH_SYLE
type npm &> /dev/null  && npm set progress=false && npm completion >> $TEMP_BASH_SYLE

echo "# Bash Prompt"
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-alias-cmd.sh >> $TEMP_BASH_SYLE
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-prompt.sh >> $TEMP_BASH_SYLE

echo  '''
# nvm - node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
''' >> $TEMP_BASH_SYLE

echo """
# synle make component
PATH=\$PATH:$UTIL_MAKE_COMPONENT_PATH
[ -s '$UTIL_MAKE_COMPONENT_PATH/setup.sh' ] && . '$UTIL_MAKE_COMPONENT_PATH/setup.sh'
""" >> $TEMP_BASH_SYLE

echo  """
# fzf - fuzzy find
[ -f ~/.fzf.bash ] && . ~/.fzf.bash
""" >> $TEMP_BASH_SYLE
