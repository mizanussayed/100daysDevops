# Day 20: Configure Nginx + PHP-FPM Using Unix Socket

## Requirements

a. Install nginx on app server 3, configure it to use port **8095** and set the document root to `/var/www/html`.

b. Install **php-fpm** on app server 3. It must use the unix socket `/var/run/php-fpm/default.sock` (create parent directories if they don't exist).

c. Configure php-fpm and nginx to work together.

d. Test the setup using:
```bash
curl http://stapp03:8095/index.php
```
from the jump host.

> **NOTE:** Files `index.php` and `info.php` are pre-copied under `/var/www/html`. Do not modify them.

---

## Solution

### 1. Install Nginx

```bash
sudo yum install nginx -y
```

### 2. Configure Nginx

Create/edit the nginx config file:

```bash
sudo vi /etc/nginx/conf.d/default.conf
```

Add the following content:

```nginx
server {
    listen 8095;
    server_name stapp03;
    root /var/www/html;
    index index.php index.html;

    location / {
        try_files $uri $uri/ =404;
    }

    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php-fpm/default.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }
}
```

> **Note:** On CentOS/RHEL, use `include fastcgi_params` (located at `/etc/nginx/fastcgi_params`).
> Do **not** use `include snippets/fastcgi-php.conf` — that file is Debian/Ubuntu-specific and does not exist on RHEL-based systems.

### 3. Install PHP-FPM

On CentOS/RHEL, use DNF module streams to install a specific PHP version:

```bash
sudo dnf module reset php -y
sudo dnf module enable php:8.1 -y
sudo dnf install php-fpm -y
```

### 4. Configure PHP-FPM Unix Socket

Edit the PHP-FPM pool config:

```bash
sudo vi /etc/php-fpm.d/www.conf
```

Find the `listen` directive and set it to exactly **one** line:

```ini
listen = /var/run/php-fpm/default.sock
```

> **Important:** Ensure there is only one `listen =` line. Having two overrides the first silently.

Create the socket directory if it doesn't exist:

```bash
sudo mkdir -p /var/run/php-fpm
```

### 5. Start and Enable PHP-FPM

```bash
sudo systemctl start php-fpm
sudo systemctl enable php-fpm
sudo systemctl status php-fpm
```

### 6. Start and Enable Nginx

```bash
sudo nginx -t
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl status nginx
```

---

## Verification

From the jump host:

```bash
curl http://stapp03:8095/index.php
curl http://stapp03:8095/info.php
```