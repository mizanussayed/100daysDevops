# Day 46: Deploy an App on Docker Containers

## 🎯 task
The Nautilus application development team recently finished an app they want to deploy on a containerized platform. They want to test the deployment on App Server 3 before going live and set up a complete container stack using Docker Compose. Below are the task details:

1. On App Server 3 in Stratos Datacenter, create a Docker Compose file at /opt/data/docker-compose.yml. The file name must match exactly.
2. The compose file must deploy two services, web and db, with the following requirements.

### Web service
- Container name must be php_host.
- Use a PHP image with an Apache tag. Check [here](https://hub.docker.com/_/php?tab=tags) for more details.
- Map port 80 in the container to port 6400 on the host.
- Map /var/www/html in the container to /var/www/html on the host.

### DB service
- Container name must be mysql_host.
- Use a MariaDB image, preferably mariadb:latest. Check [here](https://hub.docker.com/_/mariadb?tab=tags/) for more details.
- Map port 3306 in the container to port 3306 on the host.
- Map /var/lib/mysql in the container to /var/lib/mysql on the host.
- Set MYSQL_DATABASE=database_host and use a non-root database user with a strong password for connections.

After running docker-compose up, you should be able to access the app with:

```bash
curl <server-ip or hostname>:6400/
```

## Solution
```yaml
version: "3.8"

services:
  web:
    container_name: php_host
    image: php:8.3-apache
    ports:
      - "6400:80"
    volumes:
      - /var/www/html:/var/www/html

  db:
    container_name: mysql_host
    image: mariadb:latest
    ports:
      - "3306:3306"
    volumes:
      - /var/lib/mysql:/var/lib/mysql
    environment:
      MYSQL_DATABASE: database_host
      MYSQL_USER: custom_user
      MYSQL_PASSWORD: complex_password
      MYSQL_ROOT_PASSWORD: root_password
```

## Run
Use the following command to deploy the app with Docker Compose:

```bash
docker-compose -f /opt/data/docker-compose.yml up -d
```

## Verify
Confirm the deployment with:

```bash
curl <server-ip or hostname>:6400/
```

