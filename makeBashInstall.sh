if [ "$(uname)" == "Darwin" ]; then
  echo "Setting stuffs up for Mac";
  BASH_PATH=~/.bashrc;
else
  echo "Setting stuffs up for Linux";
  BASH_PATH=~/.bash_profile;
fi
echo '#syle bash' >> $BASH_PATH;
echo '. ~/.bash_syle' >> $BASH_PATH;
