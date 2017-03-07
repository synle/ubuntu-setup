#!/usr/bin/env bash

BASH_SYLE=~/.bash_syle
TEMP_BASH_SYLE=/tmp/.bash_syle

#resource nvm if needed
[ -s /opt/nvm/nvm.sh ] && . /opt/nvm/nvm.sh;
[ -s ~/.nvm/nvm.sh ] && . ~/.nvm/nvm.sh;

echo "Append ~/.bash_syle to your source if needed (idempotent)";
BASH_PATH=~/.bashrc;
[ -s ~/.bash_profile ] && BASH_PATH=~/.bash_profile
echo "Setting up in bash folder: $BASH_PATH"

grep -q -F '.bash_syle' $BASH_PATH || echo """
#syle bash
[ -s $BASH_SYLE ] && . $BASH_SYLE
""" >> $BASH_PATH



echo "Set Up Workspace: Temp Bash File: $TEMP_BASH_SYLE" 
# bash header
echo "#!/bin/bash" >> $TEMP_BASH_SYLE

#completion
echo "   Bash Completions"
curl -so- -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash >> $TEMP_BASH_SYLE
curl -so- -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/gruntjs/grunt-cli/master/completion/bash >> $TEMP_BASH_SYLE
curl -so- -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/gulpjs/gulp/master/completion/bash >> $TEMP_BASH_SYLE
eval "$(grunt --completion=bash)" >> $TEMP_BASH_SYLE

#alias
echo "   Bash Aliases"
curl -so- -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-alias-cmd.sh >> $TEMP_BASH_SYLE

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
  curl -so- -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-util-osx.sh >> $TEMP_BASH_SYLE
  
  # mac options 
  echo "      OSX Options"
  curl -so- -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/synle/ubuntu-setup/master/mac/mac.setup.sh | bash -;
elif [ $is_ubuntu == "1" ]
then
  echo "   Ubuntu Bash Specifics...";
  curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-util-ubuntu.sh | bash -;
  
  
  echo "   Ubuntu ls Bash Color Fixes"
  echo "#Fix color styles for ls" >> $TEMP_BASH_SYLE;
  echo "LS_COLORS='rs=0:di=01;36:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'" \
    >> $TEMP_BASH_SYLE;
  echo "export LS_COLORS" >> $TEMP_BASH_SYLE;

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
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.sublime.sh | bash -



#prompt
echo "   Bash Prompt"
curl -so- -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-prompt.sh >> $TEMP_BASH_SYLE


#misc
#eslint config
echo "   ESLint Config"
curl -so- -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/synle/ubuntu-setup/master/.eslintrc > ~/.eslintrc

#copy it over
echo "   Moving bash file over to home"
mv $TEMP_BASH_SYLE $BASH_SYLE

#rerun the source
echo "   Re-source bash profile"
. $BASH_SYLE
  
  
#extra stuffs
#awesome git commands
curl https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.git.config.sh | bash -

#vim stuffs
echo "   Vim & Vundle"
echo "      Vim Config .vimrc"
curl -so- -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/synle/ubuntu-setup/master/vim/.vimrc > ~/.vimrc;
echo "      Install Vundle"
rm -rf ~/.vim/bundle/Vundle.vim && git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim &> /dev/null;
vim +BundleInstall +qall &> /dev/null;
