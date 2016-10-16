#!/usr/bin/env bash

BASH_SYLE=~/.bash_syle
TEMP_BASH_SYLE=/tmp/.bash_syle
  
echo "Set up temp bash file: $TEMP_BASH_SYLE" 
# bash header
echo "#!/bin/bash" >> $TEMP_BASH_SYLE

#completion
curl -so- -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash >> $TEMP_BASH_SYLE
curl -so- -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/gruntjs/grunt-cli/master/completion/bash >> $TEMP_BASH_SYLE
curl -so- -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/gulpjs/gulp/master/completion/bash >> $TEMP_BASH_SYLE
eval "$(grunt --completion=bash)" >> $TEMP_BASH_SYLE

#alias
curl -so- -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-alias-cmd.sh >> $TEMP_BASH_SYLE

#OSX MAC GUI Stuffs
if [ "$(uname)" == "Darwin" ]; then
  echo "Set up OSX (Darwin) specifics..."
  
  # mac brew install
  echo " > OSX Brew"
  echo "       >> Install packages"
  brew install fzf jq \
    2> /dev/null


  # mac alias
  echo " > OSX Aliases"
  curl -so- -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-alias-gui.osx.sh >> $TEMP_BASH_SYLE
  
  # mac options 
  echo " > OSX Options"
  curl -so- -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/synle/ubuntu-setup/master/mac/mac.setup.sh | bash -;

  # mac sublime
  echo " > OSX Sublime"
  echo "       >> Symlink: subl"
  rm -f /usr/local/bin/subl;
  ln -sf /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl;
  chmod +x /usr/local/bin/subl;

  echo "       >> Keybinding"
  curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/sublime.mac.keybinding > ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Default\ \(OSX\).sublime-keymap
  
  echo "       >> Setting"
  curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/sublime/Preferences.sublime-settings > ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
fi

#check if is ubuntu
is_ubuntu=0
apt-get -v &> /dev/null && is_ubuntu=1
if [ $is_ubuntu == "1" ]; then
  echo "Set up Ubuntu specifics..."
  curl -so- https://github.com/synle/ubuntu-setup/blob/master/bash-alias-gui.ubuntu.sh | bash -
#   echo "Apt-Get Install"
#   sudo apt-get install jq &> /dev/null
fi



#prompt
curl -so- -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-prompt.sh >> $TEMP_BASH_SYLE


#misc
#eslint config
curl -so- -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/synle/ubuntu-setup/master/.eslintrc > ~/.eslintrc

#copy it over
echo "Moving bash file over to home"
mv $TEMP_BASH_SYLE $BASH_SYLE

#rerun the source
echo "Re-source bash profile"
. $BASH_SYLE
  
  
#extra stuffs
#awesome git commands
echo "Set up Git"
#config
git config --global user.name "Sy Le"
git config --global core.autocrlf input
git config --global core.editor vim
git config --global push.default simple
git config --global diff.tool vimdiff
git config --global diff.prompt false
git config --global merge.tool vimdiff
git config --global merge.prompt false
git config --global credential.helper cache --timeout=86400

#git alias
git config --global alias.del-merged-branches "!git branch --merged | grep -v '*' | xargs git branch -d"
git config --global alias.unstage 'reset HEAD --'
git config --global alias.co 'checkout'
git config --global alias.coo 'checkout --orphan' # new branch no history
git config --global alias.cp 'cherry-pick'
git config --global alias.cm 'commit'
git config --global alias.del 'branch -D'
git config --global alias.br 'branch -v'
git config --global alias.b 'branch'
git config --global alias.branch 'branch -a'
git config --global alias.p 'push'
git config --global alias.graph "log --all --graph --pretty=format:'%Cred%h%Creset%C(auto)%d%Creset %s %Cgreen%cr %C(bold blue)%an%Creset' --abbrev-commit --date=relative"
git config --global alias.logs 'log --oneline --decorate'
git config --global alias.l "log --pretty=format:'%Cred%h%Creset %s %Cgreen%cr %C(bold blue)%an%Creset' --abbrev-commit --date=relative"
git config --global alias.fap 'fetch --all --prune'
git config --global alias.st 'status -sb'
git config --global alias.s 'status -sb'
git config --global alias.amend 'commit --amend'
git config --global alias.nuke '!git reset --hard && git clean -dfx && git gc && git prune'
git config --global alias.push-force 'push --force-with-lease'
git config --global alias.commend 'commit --amend --no-edit'
git config --global alias.it '!git init && git commit -m “root” --allow-empty'
git config --global alias.stash 'stash --all'
#end git


#vim stuffs
echo "Set up Vim & Vundle"
rm -rf ~/.vim/bundle/Vundle.vim && git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim &> /dev/null;
curl -so- -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/synle/ubuntu-setup/master/vim/.vimrc > ~/.vimrc;
vim +BundleInstall +qall &> /dev/null;
