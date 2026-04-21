# Day 16: Install and Configure Nginx as an LBR

## 🎯 task
1. Install nginx on the LBR server if it is not installed.
2. Configure load-balancing in the `http` context using all app servers.
3. Update only the main nginx config file: `/etc/nginx/nginx.conf`.
4. Keep Apache on app servers running on port `80`.
5. Validate by accessing: `http://stlb01:80`.

## Solution
1. Install nginx on `stlb01`:

```bash
sudo yum install nginx -y
```

2. Open the main nginx config file:

```bash
sudo vi /etc/nginx/nginx.conf
```

3. In the `http { ... }` block, set the upstream and proxy configuration.

```nginx
http {
    log_format main '$remote_addr - $remote_user [$time_local] "$request" '
                    '$status $body_bytes_sent '
                    'upstream: $upstream_addr '
                    '"$http_user_agent"';

    access_log /var/log/nginx/access.log main;

    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    upstream app_servers {
        server stapp01:8088;
        server stapp02:8088;
        server stapp03:8088;
    }

    server {
        listen 80;
        listen [::]:80;
        server_name _;

        location / {
            proxy_pass http://app_servers;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }

        error_page 404 /404.html;
        location = /404.html { }

        error_page 500 502 503 504 /50x.html;
        location = /50x.html { }
    }
}
```

4. Test and restart nginx:

```bash
sudo nginx -t
sudo systemctl restart nginx
sudo systemctl enable nginx
```

5. Verify active nginx config includes all app servers:

```bash
sudo nginx -T 2>/dev/null | grep -nE "upstream app_servers|server stapp01:8088;|server stapp02:8088;|server stapp03:8088;|proxy_pass http://app_servers;"
```

6. Verify load balancer endpoint:

```bash
curl http://stlb01:80
```

7. Watch access logs in real time:

```bash
sudo tail -f /var/log/nginx/access.log
```

8. Verify Apache is running on each app server:

```bash
sudo systemctl status httpd
```


## load test the LBR by sending multiple requests and watching the access logs:
```bash
for i in {1..6}; do curl -s http://stlb01:80 > /dev/null; done
sudo tail -f /var/log/nginx/access.log
```




