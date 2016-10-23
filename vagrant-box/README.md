## Hook up vagrant init file

```
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/vagrant-box/Vagrantfile > ./Vagrantfile;
curl -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/vagrant-box/setup.sh > ./setup.sh;
vagrant up;
```


## Then run this
```
vagrant ssh;
su syle;
#
curl -H 'Cache-Control: no-cache' -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/makeBashInstall.sh | bash;
curl -H 'Cache-Control: no-cache' -so- https://raw.githubusercontent.com/synle/ubuntu-setup/master/makeBashRefresh.sh | bash;
```
