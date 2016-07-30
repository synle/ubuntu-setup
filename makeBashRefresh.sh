#!/usr/bin/env bash
echo "make bash local"
  #empty the file
  BASH_SYLE=~/.bash_syle
  TEMP_BASH_SYLE=/tmp/.bash_syle
  
echo 'Setting up in ' + $TEMP_BASH_SYLE
  # bash header
  echo "#!/bin/bash" >> $TEMP_BASH_SYLE

  #completion
  curl -so- https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash >> $TEMP_BASH_SYLE
  curl -so- https://raw.githubusercontent.com/gruntjs/grunt-cli/master/completion/bash >> $TEMP_BASH_SYLE
  curl -so- https://raw.githubusercontent.com/gulpjs/gulp/master/completion/bash >> $TEMP_BASH_SYLE
  eval "$(grunt --completion=bash)" >> $TEMP_BASH_SYLE

  #alias
  curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-alias-cmd.sh >> $TEMP_BASH_SYLE

  #specific to mac
  if [ "$(uname)" == "Darwin" ]; then
    echo "Install Mac specific alias"
    curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-alias-gui.sh >> $TEMP_BASH_SYLE
  fi


  #prompt
  curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-prompt.sh >> $TEMP_BASH_SYLE
  
  
#copy it over
mv $TEMP_BASH_SYLE $BASH_SYLE

#rerun the source
. $BASH_SYLE
