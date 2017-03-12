# SSH Without Keys
===============
http://www.linuxproblem.org/art_9.html

```
cat .ssh/id_rsa.pub | ssh b@B 'cat >> .ssh/authorized_keys'
```
