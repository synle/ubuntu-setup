# SSH Without Keys
===============
http://www.linuxproblem.org/art_9.html

```
cat ~/.ssh/id_rsa.pub | ssh b@B 'cat >> .ssh/authorized_keys'
```
## XPS 13 Elementary OS Loki Wifi Fix
https://elementaryos.stackexchange.com/questions/6885/xps-13-9350-wifi-issue-in-loki-but-not-in-ubuntu-16-04

```
sudo apt-get purge bcmwl-kernel-source
reboot
```
