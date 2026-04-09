# Day 41: Write a Docker File

## Objective
Create `/opt/docker/Dockerfile` on App Server 2 in Stratos DC and build an image with the following requirements:

- Use `ubuntu:24.04` as the base image.
- Install `apache2` and configure it to work on port `8086`.
- Do not change any other Apache configuration settings such as the document root.

## Dockerfile

```dockerfile
FROM ubuntu:24.04
RUN apt-get update && apt-get install -y apache2 && sed -i 's/Listen 80/Listen 8086/' /etc/apache2/ports.conf && sed -i 's/:80>/:8086>/' /etc/apache2/sites-available/000-default.conf
EXPOSE 8086
CMD ["apache2ctl", "-D", "FOREGROUND"]
```

## Commands

```bash
cd /opt/docker

cat > Dockerfile <<'EOF'
FROM ubuntu:24.04
RUN apt-get update && apt-get install -y apache2 && sed -i 's/Listen 80/Listen 8086/' /etc/apache2/ports.conf && sed -i 's/:80>/:8086>/' /etc/apache2/sites-available/000-default.conf
EXPOSE 8086
CMD ["apache2ctl", "-D", "FOREGROUND"]
EOF

docker build --no-cache -t custom-apache:latest .
docker run -d --name apache-test -p 8086:8086 custom-apache:latest
docker ps
curl -I http://localhost:8086
```