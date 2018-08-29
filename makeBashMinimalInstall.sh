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



# make-component
echo "  Make Component Scripts"
UTIL_MAKE_COMPONENT_PATH=~/synle-make-component
rm -rf $UTIL_MAKE_COMPONENT_PATH && git clone --depth 1 -b master https://github.com/synle/make-component.git $UTIL_MAKE_COMPONENT_PATH &> /dev/null
pushd $UTIL_MAKE_COMPONENT_PATH 
npm i && npm run build
popd


# fzf (fuzzy find)
echo "fzf installation"
rm -rf ~/.fzf && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf  &> /dev/null

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



# terminator config
echo 'terminator config'
[ -s ~/.config/terminator/config ] && echo '''
[global_config]
[keybindings]
[layouts]
  [[default]]
    [[[child1]]]
      parent = window0
      type = Terminal
    [[[window0]]]
      parent = ""
      type = Window
[plugins]
[profiles]
  [[default]]
    antialias = False
    show_titlebar = False
    use_system_font = False
''' > ~/.config/terminator/config


curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.git.config.sh | bash -
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.vim.sh | bash -
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/misc/eslintrc > ~/.eslintrc
