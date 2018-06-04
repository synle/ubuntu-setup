    BASH_SYLE=~/.bash_syle

echo '# begin syle bash' > $BASH_SYLE

# bash completion
echo  "# Bash Completion - git" >> $BASH_SYLE
curl -so- https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash >> $BASH_SYLE
echo  "# Bash Completion - npm" >> $BASH_SYLE
type npm &> /dev/null  && npm set progress=false && npm completion >> $BASH_SYLE


# nvm, node and npm
echo "nvm & node & npm modules"
NVM_BASE_PATH=~/.nvm
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.nvm.node.sh | bash -
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.npm.node.sh | bash -

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
""" >> $BASH_SYLE
popd


# fzf (fuzzy find)
echo "fzf installation"
rm -rf ~/.fzf && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf  &> /dev/null
echo "install fzf with this command"
echo "~/.fzf/install"

curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-alias-cmd.sh >> $BASH_SYLE
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-prompt.sh >> $BASH_SYLE
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.git.config.sh | bash -
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.vim.sh | bash -

. $BASH_SYLE
