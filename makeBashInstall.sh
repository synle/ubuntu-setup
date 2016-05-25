BASH_PATH=~/.bashrc;

if [ "$(uname)" == "Darwin" ]; then
  BASH_PATH=~/.bash_profile;
fi

echo "Setting up in bash folder: $BASH_PATH"
echo '#syle bash' >> $BASH_PATH;
echo '. ~/.bash_syle' >> $BASH_PATH;
