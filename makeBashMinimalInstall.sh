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


# botstrap if needed
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


##################################################################
#### Extra Stuffs ####
##################################################################
# nvm, node and npm
echo "nvm & node & npm modules"
NVM_BASE_PATH=~/.nvm
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.nvm.node.sh | bash -
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.npm.node.sh | bash -
grep -q -F 'nvm.sh' $BASH_PATH || echo  """
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
""" >> $BASH_PATH


# make-component
echo "  Make Component Scripts"
UTIL_MAKE_COMPONENT_PATH=~/synle-make-component
rm -rf $UTIL_MAKE_COMPONENT_PATH && git clone --depth 1 -b master https://github.com/synle/make-component.git $UTIL_MAKE_COMPONENT_PATH &> /dev/null
pushd $UTIL_MAKE_COMPONENT_PATH 
npm i && npm run build
echo """
# synle make component
PATH=\$PATH:$UTIL_MAKE_COMPONENT_PATH
[ -s '$UTIL_MAKE_COMPONENT_PATH/setup.sh' ] && . '$UTIL_MAKE_COMPONENT_PATH/setup.sh'
""" >> $TEMP_BASH_SYLE
popd


# fzf (fuzzy find)
echo "fzf installation"
rm -rf ~/.fzf && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf  &> /dev/null
grep -q -F '/.fzf' $BASH_PATH || echo  """
[ -f ~/.fzf.bash ] && . ~/.fzf.bash
""" >> $BASH_PATH



# tmux stuffs
# http://www.hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/
# https://superuser.com/questions/209437/how-do-i-scroll-in-tmux
# http://stackoverflow.com/questions/25532773/change-background-color-of-active-or-inactive-pane-in-tmux/33553372#33553372
echoo "Tmux"
echo """
#not show status bar
set -g status off
#scroll history
set -g history-limit 30000
# Window options
set -g monitor-activity off
#mouse support
set -g mode-mouse on
set -g mouse-resize-pane on
set -g mouse-select-pane on
set -g mouse-select-window on
""" > ~/.tmux.conf


curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.git.config.sh | bash -
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.vim.sh | bash -
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/misc/eslintrc > ~/.eslintrc
