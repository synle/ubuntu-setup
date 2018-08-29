# complex commands
git config --global alias.del-merged         "!git branch --merged | grep -v '*' | xargs git branch -d"
git config --global alias.del-merged-staging "!git branch --merged origin/staging | grep -v '*' | xargs git branch -d"
git config --global alias.graph "log --all --graph --pretty=format:'%Cred%h%Creset%C(auto)%d%Creset %s %Cgreen%cr %C(bold blue)%an%Creset' --abbrev-commit --date=relative"
git config --global alias.l "log --pretty=format:'%Cred%h%Creset %s %Cgreen%cr %C(bold blue)%an%Creset' --abbrev-commit --date=relative"

curl -s https://raw.githubusercontent.com/synle/ubuntu-setup/master/misc/gitignoreGlobal > ${HOME}/.gitignore
