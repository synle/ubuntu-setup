##########################################################################################################
#
# begin prep work
# 
##########################################################################################################
BASH_SYLE=~/.bash_syle
TEMP_BASH_SYLE=/tmp/.bash_syle
BASH_PATH=~/.bashrc
BIN_PATH=/usr/bin
TEMP_BIN_PATH=/tmp

# os flags
is_os_darwin_mac=0
is_os_ubuntu=0
is_os_redhat=0
is_os_window=0
[ -d /Library ] && is_os_darwin_mac=1
[ -d /mnt/c/Users ] && is_os_window=1
[ -s /usr/bin/apt ] && is_os_ubuntu=1
[ -s /usr/bin/apt-get ] && is_os_ubuntu=1
yum -v &>/dev/null && is_os_redhat=1


# prep works...
# go to home and start
cd ~

# common functions
function curll(){ curl -s $@; }
function echoo(){ printf "\e[1;31m$@\n\e[0m"; }
##########################################################################################################
#
# end prep work
# 
##########################################################################################################


# bootstrap if needed
echoo "Install .bash_syle if needed"
grep -q -F '.bash_syle' $BASH_PATH || echo  """
# syle bash
[ -s $BASH_SYLE ] && . $BASH_SYLE
""" >> $BASH_PATH


### start bash-syle
echo  "#!/bin/bash" >> $TEMP_BASH_SYLE
echo '# begin syle bash' > $TEMP_BASH_SYLE

# http://unix.stackexchange.com/questions/21092/how-can-i-reset-all-the-bind-keys-in-my-bash
echo '''
# Reset Bash KeyMap
set -o vi;''' >> $TEMP_BASH_SYLE

# bash completion
echo  "# Bash Completion - git" >> $TEMP_BASH_SYLE
curll https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash >> $TEMP_BASH_SYLE
echo  "# Bash Completion - npm" >> $TEMP_BASH_SYLE
type npm &>/dev/null  && npm set progress=false && npm completion >> $TEMP_BASH_SYLE

echo "# Bash Prompt"
curll https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-alias-cmd.sh >> $TEMP_BASH_SYLE
curll https://raw.githubusercontent.com/synle/ubuntu-setup/master/bash-prompt.sh >> $TEMP_BASH_SYLE


##########################################################################################################
#
# nvm
# 
##########################################################################################################
NVM_BASE_PATH=~/.nvm
#install nvm itself.
echo 'nvm install'
curll https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash &>/dev/null
[ -d $NVM_BASE_PATH ] && echo "  SKIP git clone nvm"
. "$NVM_BASE_PATH/nvm.sh"
echo 'nvm install 7.6'
nvm install 7.6 &>/dev/null
nvm use default &>/dev/null
echo  '''
# nvm - node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
''' >> $TEMP_BASH_SYLE
# echo "  nvm node symlink"
# sudo ln -f -s $NVM_BASE_PATH/versions/node/v0.12.15/bin/node /usr/local/bin/node
# sudo ln -f -s $NVM_BASE_PATH/versions/node/v0.12.15/bin/npm  /usr/local/bin/npm


##########################################################################################################
#
# node
# 
##########################################################################################################
. "$NVM_BASE_PATH/nvm.sh"
function npm-install-global(){
  echo "  $@";
  npm install -g $@ &>/dev/null
}
echo 'npm install -g'
npm-install-global webpack
npm-install-global eslint
npm-install-global typings
npm-install-global less
npm-install-global create-react-app


##########################################################################################################
#
# synle-make-component
# 
##########################################################################################################
UTIL_MAKE_COMPONENT_PATH=~/synle-make-component
rm -rf $UTIL_MAKE_COMPONENT_PATH && git clone --depth 1 -b master https://github.com/synle/make-component.git $UTIL_MAKE_COMPONENT_PATH &>/dev/null
pushd $UTIL_MAKE_COMPONENT_PATH
echo 'synle-make-component install'
npm i &>/dev/null && npm run build  &>/dev/null
popd

echo """
# synle make component
PATH=\$PATH:$UTIL_MAKE_COMPONENT_PATH
[ -s '$UTIL_MAKE_COMPONENT_PATH/setup.sh' ] && . '$UTIL_MAKE_COMPONENT_PATH/setup.sh'
""" >> $TEMP_BASH_SYLE

##########################################################################################################
#
# create the syle bookmark file
# 
##########################################################################################################
touch ~/.syle_bookmark


##########################################################################################################
#
# fzf - fuzzy find
# 
##########################################################################################################
echo 'fzf install'
rm -rf ~/.fzf && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf  &>/dev/null
echo  """
# fzf - fuzzy find
[ -f ~/.fzf.bash ] && . ~/.fzf.bash
""" >> $TEMP_BASH_SYLE



# git magics
echo """
##########################################################################################################
#         git
#    / ___|_ _|_   _|
#   | |  _ | |  | |
#   | |_| || |  | |
#    \____|___| |_|
##########################################################################################################
# config
git config --global user.name 'Sy Le'
git config --global core.excludesfile ${HOME}/.gitignore
git config --global core.autocrlf input
git config --global core.editor vim
git config --global diff.tool vimdiff
git config --global diff.prompt false
git config --global merge.tool vimdiff
git config --global merge.prompt false
# git alias
git config --global alias.unstage 'reset HEAD --'
git config --global alias.co 'checkout'
git config --global alias.cob 'checkout -b'
git config --global alias.coo 'checkout --orphan' # new branch no history
git config --global alias.cp 'cherry-pick'
git config --global alias.cpn 'cherry-pick -n'
git config --global alias.cm 'commit'
git config --global alias.clone-shallow 'clone --depth 1 -b master'
git config --global alias.del 'branch -D'
git config --global alias.b 'branch'
git config --global alias.br 'branch -v'
git config --global alias.diff-no-space 'diff -w'
git config --global alias.d-no-space 'diff -w'
git config --global alias.d 'git diff --word-diff'
git config --global alias.brav 'branch -av'
git config --global alias.p 'push origin'
git config --global alias.pd 'push origin'
git config --global alias.push-delete 'push -d'
git config --global alias.pushd 'push -d'
git config --global alias.del-push 'push -d'
git config --global alias.p-force 'push --force-with-lease origin'
git config --global alias.logs 'log --oneline --decorate'
git config --global alias.r 'rebase'
git config --global alias.reb 'rebase'
git config --global alias.ri 'rebase -i'
git config --global alias.fap 'fetch --all --prune'
git config --global alias.st 'status'
git config --global alias.s 'status -sb'
git config --global alias.amend 'commit --amend'
git config --global alias.nuke '!git reset --hard && git clean -dfx && git gc && git prune'
git config --global alias.commend 'commit --amend --no-edit'
git config --global alias.stash-all 'stash --all'
git config --global alias.fix-author 'commit --amend --reset-author'
git config --global alias.it '!git init && git commit -m "root" --allow-empty'
git config --global color.ui true
git config --global color.diff-highlight.oldNormal    "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal    "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"
git config --global color.diff.meta       "yellow"
git config --global color.diff.frag       "magenta bold"
git config --global color.diff.commit     "yellow bold"
git config --global color.diff.old        "red bold"
git config --global color.diff.new        "green bold"
git config --global color.diff.whitespace "red reverse"
# complex commands
git config --global alias.del-merged         \"!git branch --merged | grep -v '*' | xargs git branch -d\"
git config --global alias.del-merged-staging \"!git branch --merged origin/staging | grep -v '*' | xargs git branch -d\"
git config --global alias.graph \"log --all --graph --pretty=format:'%Cred%h%Creset%C(auto)%d%Creset %s %Cgreen%cr %C(bold blue)%an%Creset' --abbrev-commit --date=relative\"
git config --global alias.l \"log --pretty=format:'%Cred%h%Creset %s %Cgreen%cr %C(bold blue)%an%Creset' --abbrev-commit --date=relative\"
""" >> $TEMP_BASH_SYLE

echo """
# global git ignore
#nodes
node_modules

# Compiled source #
##########################################################################################################
*.com
*.class
*.dll
*.exe
*.o
*.so

# Packages #
##########################################################################################################
# it's better to unpack these files and commit the raw source
# git has its own built in compression methods
*.7z
*.dmg
*.gz
*.iso
*.jar
*.rar
*.tar
*.zip

# Logs and databases #
##########################################################################################################
*.log
*.sql
*.sqlite

# OS generated files #
##########################################################################################################
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db
""" > ~/.gitignore





# eslintrc
echo '''
{
    "extends": "airbnb",
    "env": {
        "browser": true
    },
    "plugins": [
        "jsx-a11y"
    ],
    "globals": {
        "$": true,
        "angular": true
    },
    "rules": {
        "indent": [
            2,
            2,
            {
                "outerIIFEBody": 0,
                "MemberExpression": 1
            }
        ],
        "comma-dangle": ["error", "never"],
        "keyword-spacing": [2, {"before": true, "after": true}],
        "no-underscore-dangle": [0],
        "prefer-template": [0],
        "jsx-a11y/aria-role": [0],
        "no-else-return": [0],
        "quote-props": [0],
        "one-var": [0],
        "react/prop-types": [0],
        "react/self-closing-comp": [0],
        "react/jsx-filename-extension": [0],
        "react/prefer-stateless-function": [0],
        "react/jsx-closing-bracket-location": [0]
    }
}
'''  > ~/.eslintrc


# vim config
echo """
\" theme
  color desert
  set background=dark

\" options
set hlsearch
set showmatch
set ignorecase
set tabstop=4
set shell=/bin/bash


\" syntax highlight
  syntax on
  filetype on
  au BufNewFile,BufRead *.cmp set filetype=xml
  au BufNewFile,BufRead *.app set filetype=xml

\" vundle stuffs
  set nocompatible              \" be iMproved, required
  filetype off                  \" required

  \" set the runtime path to include Vundle and initialize
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()

  Plugin 'VundleVim/Vundle.vim'
  Plugin 'airblade/vim-gitgutter'
  Plugin 'dracula/vim'

  \" All of your Plugins must be added before the following line
  call vundle#end()            \" required

  filetype on
""" > ~/.vimrc

# install Vim Vundle
echo 'vim vundle install'
[ -d ~/.vim/bundle/Vundle.vim ] \
    || git clone --depth 1 -b master https://github.com/gmarik/Vundle.vim.git \
    ~/.vim/bundle/Vundle.vim &>/dev/null
vim +BundleInstall +qall &>/dev/null



##########################################################################################################
##########################################################################################################
##########################################################################################################
#
#
# extremely small install (only install if needed)
#
#
##########################################################################################################
##########################################################################################################
##########################################################################################################



##########################################################################################################
#
# tmux stuffs
# http://www.hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/
# https://superuser.com/questions/209437/how-do-i-scroll-in-tmux
# http://stackoverflow.com/questions/25532773/change-background-color-of-active-or-inactive-pane-in-tmux/33553372#33553372
# 
##########################################################################################################
echoo "Tmux"
[ -s ~/.tmux.conf ] && echo """
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




##########################################################################################################
#
# terminator config
# 
##########################################################################################################
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



##########################################################################################################
#
# ubuntu gui tweaks
# lcfe tweak: speed bump
# vim ~/.config/openbox/lubuntu-rc.xml
#
##########################################################################################################
[ -s ~/.config/openbox/lubuntu-rc.xml ] && \
  sed -i "s/<animateIconify>yes<\/animateIconify>/<animateIconify>no<\/animateIconify>/g" \
  ~/.config/openbox/lubuntu-rc.xml



##########################################################################################################
#
# aweseome cli improved tips from https://remysharp.com/2018/08/23/cli-improve
# 
##########################################################################################################

##########################################################################################################
#
# add prettyping: http://denilson.sa.nom.br/prettyping/
# 
##########################################################################################################
echo 'install prettyping'
curll https://raw.githubusercontent.com/denilsonsa/prettyping/master/prettyping > $TEMP_BIN_PATH/prettyping
chmod +x $TEMP_BIN_PATH/prettyping
sudo cp $TEMP_BIN_PATH/prettyping $BIN_PATH/prettyping


##########################################################################################################
#
# diff-so-fancy and integration with git
# 
##########################################################################################################
echo 'install diff-so-fancy'
curll https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy > $TEMP_BIN_PATH/diff-so-fancy
chmod +x $TEMP_BIN_PATH/diff-so-fancy
sudo cp $TEMP_BIN_PATH/diff-so-fancy $BIN_PATH/diff-so-fancy
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"


##########################################################################################################
#      _
#   __| | ___  _ __   ___
#  / _` |/ _ \| '_ \ / _ \
# | (_| | (_) | | | |  __/
#  \__,_|\___/|_| |_|\___|
#  
##########################################################################################################
cat $TEMP_BASH_SYLE > $BASH_SYLE
