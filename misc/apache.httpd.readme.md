We need to load these modules...

## Location
### Mac
```
/etc/apache2/httpd.conf
```

### Redhat
```
/etc/httpd/conf.d/ssl.conf
```

## Restart Apache HTTPD
```
sudo apachectl restart; sudo httpd
```

## Required Modules
### Mac
```
#LoadModule ssl_module libexec/apache2/mod_ssl.so
#LoadModule proxy_module libexec/apache2/mod_proxy.so
#LoadModule proxy_http_module libexec/apache2/mod_proxy_http.so
```

### Redhat
```
#LoadModule ssl_module /usr/lib64/apache2-prefork/mod_ssl.so
```


## Sample httpd config
```
LoadModule ssl_module /usr/lib64/apache2-prefork/mod_ssl.so

ErrorLog /var/log/nginx/ssl_error_log
Listen 8099
Listen 443

<VirtualHost *:8099>
    DocumentRoot /var/www/html/myapp

    <Directory />
      Require all granted
    </Directory>

    <Location />
      Require all granted
    </Location>

    <Directory "/var/www/html/myapp">
      Require all granted
    </Directory>

    <Location "/var/www/html/myapp">
      Require all granted
    </Location>
</VirtualHost>




<VirtualHost *:443>
    SSLEngine on
    SSLProtocol all -SSLv2
    SSLCipherSuite DEFAULT:!EXP:!SSLv2:!DES:!IDEA:!SEED:+3DES
    SSLCertificateFile /etc/pki/tls/certs/01198793-Certificate.crt
    SSLCertificateKeyFile /etc/pki/tls/certs/01198793-PrivateKey_no_pass.key

    ProxyPass "/" "http://localhost:8099/"
    ProxyPassReverse "/" "http://localhost:8099/"
</VirtualHost>

```
