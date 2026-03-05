# Day 15: Setup SSL for Nginx

1. Install and configure nginx on App Server 2.

2. On App Server 2 there is a self signed SSL certificate and key present at location /tmp/nautilus.crt and /tmp/nautilus.key. Move them to some appropriate location and deploy the same in Nginx.

3. Create an index.html file with content Welcome! under Nginx document root.

4. For final testing try to access the App Server 2 link (either hostname or IP) from jump host using curl command. For example 
`curl -Ik https://<app-server-ip>/`

## Solution
1. Install nginx on App Server 2 (centos) using the command
 `sudo yum install nginx -y`

2. Move the SSL certificate and key to /etc/ssl/certs and /etc/ssl/private respectively using the commands
    `sudo mv /tmp/nautilus.crt /etc/ssl/certs/`
    `sudo mv /tmp/nautilus.key /etc/ssl/private/`

3. Create an index.html file with content Welcome! under Nginx document root using the command
    `echo "Welcome!" | sudo tee /usr/share/nginx/html/index.html`

4. Edit the nginx configuration file to enable SSL. Open the file /etc/nginx/nginx.conf and add the following server block inside the http block:
```bash
server {
    listen 80;
    listen 443 ssl;
    server_name <app-server-ip>;
    ssl_certificate /etc/ssl/certs/nautilus.crt;
    ssl_certificate_key /etc/ssl/private/nautilus.key;
    location / {
        root /usr/share/nginx/html;
        index index.html;
    }
}
```

5. Save the file and exit. Then restart nginx to apply the changes using the command
    `sudo systemctl restart nginx`
6. Finally, test the setup by accessing the App Server 2 link from the jump host using the command
    `curl -Ik https://<app-server-ip>/`


## Note
create self signed SSL certificate and key using the following command if not present
```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /tmp/nautilus.key -out /tmp/nautilus.crt \
-subj "/CN=nautilus/O=nautilus/C=IN"
```