BASH_PATH=~/.bash_profile;

if [ "$(uname)" == "Darwin" ]
then
  echo "Setting stuffs up for Mac";
  BASH_PATH=~/.bashrc;
fi

echo "Setting up in bash folder: $BASH_PATH"
echo '#syle bash' >> $BASH_PATH;
echo '. ~/.bash_syle' >> $BASH_PATH;
