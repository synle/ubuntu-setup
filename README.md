# Common Bash Util.

## Install

### Full Install
```
sudo apt-get update -y; 
sudo apt-get install -y curl;
curl -s https://raw.githubusercontent.com/synle/ubuntu-setup/master/makeBashInstall.sh | bash
```

### Minimal Install
```
curl -s https://raw.githubusercontent.com/synle/ubuntu-setup/master/makeBashMinimalInstall.sh | bash && mv /tmp/.bash_syle > ~/.bash_syle
```



### minor stuffs

#### android adb on mac
https://stackoverflow.com/questions/17901692/set-up-adb-on-mac-os-x

```echo "export PATH=\$PATH:/Users/${USER}/Library/Android/sdk/platform-tools/" >> ~/.bash_profile```
