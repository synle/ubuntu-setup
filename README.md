# Common Bash Util.

## Install

### Full Install
```
# for ubuntu
apt -v &> /dev/null && alias apt-get="apt"
sudo apt-get update -y;
sudo apt-get install -y curl;

# the main script
curl -s https://raw.githubusercontent.com/synle/ubuntu-setup/master/makeBashInstall.sh | bash
```

### Minimal Install
```
curl -s https://raw.githubusercontent.com/synle/ubuntu-setup/master/makeBashMinimalInstall.sh | bash
```



### minor stuffs

#### android adb on mac
https://stackoverflow.com/questions/17901692/set-up-adb-on-mac-os-x

```echo "export PATH=\$PATH:/Users/${USER}/Library/Android/sdk/platform-tools/" >> ~/.bash_profile```
