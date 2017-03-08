#!/usr/bin/env bash

BASH_SYLE=~/.bash_syle
TEMP_BASH_SYLE=/tmp/.bash_syle

#resource nvm if needed
[ -s /opt/nvm/nvm.sh ] && . /opt/nvm/nvm.sh;
[ -s ~/.nvm/nvm.sh ] && . ~/.nvm/nvm.sh;

#define some necessary functions
function curlNoCache(){
    curl -so- -H 'Cache-Control: no-cache' "$@?$(date +%s)"
}

echo "Append ~/.bash_syle to your source if needed (idempotent)";
BASH_PATH=~/.bashrc;
[ -s ~/.bash_profile ] && BASH_PATH=~/.bash_profile
echo "Setting up in bash folder: $BASH_PATH"

grep -q -F '.bash_syle' $BASH_PATH || echo """
#syle bash
[ -s $BASH_SYLE ] && . $BASH_SYLE
""" >> $BASH_PATH



echo "Install Prerequisites"
echo "    Install Global Node Modules"
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.npm.node.sh | bash


echo "Set Up Workspace: Temp Bash File: $TEMP_BASH_SYLE" 
# bash header
echo "#!/bin/bash" >> $TEMP_BASH_SYLE

#completion
echo "   Bash Completions"
echo "       Git Completion"
curlNoCache https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash >> $TEMP_BASH_SYLE
echo "       Grunt(Node JS) Completion"
curlNoCache https://raw.githubusercontent.com/gruntjs/grunt-cli/master/completion/bash >> $TEMP_BASH_SYLE
echo "       Gulp(Node JS) Completion"
curlNoCache https://raw.githubusercontent.com/gulpjs/gulp/master/completion/bash >> $TEMP_BASH_SYLE
eval "$(grunt --completion=bash)" >> $TEMP_BASH_SYLE

#alias
echo "   Bash Aliases"
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-alias-cmd.sh >> $TEMP_BASH_SYLE

#flags
#check if is ubuntu
is_ubuntu=0
apt-get -v &> /dev/null && is_ubuntu=1


#OSX MAC GUI Stuffs
if [ "$(uname)" == "Darwin" ]
then
  echo "   OSX (Darwin) specifics..."
  
  # mac brew install
  echo "      OSX Brew"
  echo "         Install packages"
  brew install fzf jq \
    2> /dev/null


  # mac alias
  echo "      OSX Aliases"
  curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-util-osx.sh >> $TEMP_BASH_SYLE
  
  # mac options 
  echo "      OSX Options"
  curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/mac/mac.setup.sh | bash -;
elif [ $is_ubuntu == "1" ]
then
  echo "   Ubuntu Bash Specifics...";
  curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-util-ubuntu.sh >> $TEMP_BASH_SYLE

  if [ -d "/mnt/c/Users" ]; then
    echo "   Windows 10 Bash Specifics...";
  else
    echo "Real Ubuntu"
  fi
fi


# echo "      Reset Bash KeyMap";
# set -o vi;
#     http://unix.stackexchange.com/questions/21092/how-can-i-reset-all-the-bind-keys-in-my-bash


#sublime
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.sublime.sh | bash -



#prompt
echo "   Bash Prompt"
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-prompt.sh >> $TEMP_BASH_SYLE


#misc
#eslint config
echo "   ESLint Config"
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/.eslintrc > ~/.eslintrc

#copy it over
echo "   Moving bash file over to home"
mv $TEMP_BASH_SYLE $BASH_SYLE

#rerun the source
echo "   Re-source bash profile"
. $BASH_SYLE
  
  
#extra stuffs
#awesome git commands
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.git.config.sh | bash -

#vim stuffs
echo "   Vim & Vundle"
echo "      Install Vundle"
rm -rf ~/.vim/bundle/Vundle.vim && git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim &> /dev/null;
echo "      Vim Config .vimrc"
curlNoCache https://raw.githubusercontent.com/synle/ubuntu-setup/master/vim/.vimrc > ~/.vimrc;
echo "      Finalize Vim and Vundle..."
vim +BundleInstall +qall &> /dev/null;
