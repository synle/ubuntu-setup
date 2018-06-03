BASH_SYLE=~/.bash_syle

echo '# begin syle bash' > $BASH_SYLE

# bash completion
echoo "Bash Completions"
echo  "  Git Completion"
curl -so- https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash >> $BASH_SYLE
echo  "  NPM Completion"
type npm &> /dev/null  && npm set progress=false && npm completion >> $BASH_SYLE


curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-alias-cmd.sh >> $BASH_SYLE
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-prompt.sh >> $BASH_SYLE
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.git.config.sh | bash -
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/install.vim.sh | bash -

. $BASH_SYLE
