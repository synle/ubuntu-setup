BASH_SYLE=~/.bash_syle

echo '# begin syle bash' > $BASH_SYLE
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-alias-cmd.sh >> $BASH_SYLE
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-prompt.sh >> $BASH_SYLE
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.git.config.sh | bash -
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.vim.sh | bash -

. $BASH_SYLE
