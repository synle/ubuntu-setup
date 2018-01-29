# Nginx
## Location
### Mac
```
/usr/local/etc/nginx/nginx.conf
```

### Redhat
```
/etc/nginx/nginx.conf
```


## Restart Nginx
```
sudo nginx -s stop; sudo nginx;
```


## Sample Nginx File
```
worker_processes  4;

error_log  /var/log/nginx/error.log;

events {
    worker_connections  1024;
}


http {
    sendfile                    on;
    include                     mime.types;
    keepalive_timeout           600;
    proxy_connect_timeout       600;
    proxy_send_timeout          600;
    proxy_read_timeout          600;
    send_timeout                600;


    # fe
    upstream myapp-fe-localhost {
        server localhost:8099;
    }

    upstream myapp-fe-stage {
        server us-central-myapp7.abcdef.com:8099;
    }

    upstream myapp-fe-prod {
        server us-west-myapp2.abcdef.com:8099;
        server us-west-myapp8.abcdef.com:8099;
        server us-west-myapp9.abcdef.com:8099;
        server us-east-myapp2.abcdef.com:8099;
        server us-east-myapp8.abcdef.com:8099;
        server us-east-myapp7.abcdef.com:8099;
    }

    # be
    upstream myapp-be-stage {
        server us-central-myapp7.abcdef.com:8098;
        server us-central-myapp6.abcdef.com:8098;
        server us-central-myapp5.abcdef.com:8098;
    }

    upstream myapp-be-prod {
        # prod
        server us-west-myapp2.abcdef.com:8098;
        server us-west-myapp8.abcdef.com:8098;
        server us-west-myapp9.abcdef.com:8098;
        # prod dr
        server us-east-myapp2.abcdef.com:8098;
        server us-east-myapp8.abcdef.com:8098;
        server us-east-myapp7.abcdef.com:8098;
    }


    # port 80 to redirect to 443
    server {
        listen       80;
        return       301 https://$host;
    }

    # serve static content on 8099
    server {
        listen       8099;

        # file...
        root /var/www/html/app;
    }

    # serve https
    server {
        listen       443;

        # ssl and server
        server_name myapp.abcdef.com;
        ssl on;
        ssl_certificate /etc/certs/server.crt;
        ssl_certificate_key /etc/certs/server.key;

        # api
        location /api/v1/ {
            # proxy_pass http://myapp-be-prod;
            proxy_pass http://myapp-be-stage;
        }

        location / {
            proxy_pass http://myapp-fe-localhost;
            # proxy_pass http://myapp-fe-stage;
            # proxy_pass http://myapp-fe-prod;
        }
    }

    # add header for host
    add_header X-Forwarded-Host $host;
    add_header X-Forwarded-For $proxy_add_x_forwarded_for;
    add_header X-Remote-Addr $remote_addr;
    add_header X-Upstream-Addr $upstream_addr;

    include servers/*;
}
```
