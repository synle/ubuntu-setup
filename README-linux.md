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


## PHP Nginx Bad Gateawy 502 Troubleshooting
http://stackoverflow.com/questions/10003978/php-fpm-and-nginx-502-bad-gateway
```
sudo vim /etc/php5/fpm/pool.d/www.conf

pm.max_children = 70
pm.start_servers = 20
pm.min_spare_servers = 20
pm.max_spare_servers = 35
pm.max_requests = 500

/var/www/html
```


## Custom Resolution in Ubuntu
http://ubuntuhandbook.org/index.php/2017/04/custom-screen-resolution-ubuntu-desktop/
```
>>> cvt 2560 1440
# 2560x1440 59.96 Hz (CVT 3.69M9) hsync: 89.52 kHz; pclk: 312.25 MHz
Modeline "2560x1440_60.00"  312.25  2560 2752 3024 3488  1440 1443 1448 1493 -hsync +vsync


>>> sudo xrandr --newmode  "2560x1440_60.00"  312.25  2560 2752 3024 3488  1440 1443 1448 1493 -hsync +vsync

>>>  sudo xrandr --addmode eDP-1  "2560x1440_60.00"
```
