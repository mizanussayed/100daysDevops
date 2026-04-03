# Day 35: Install Docker Packages and Start Docker Service

##  Objective
The Nautilus DevOps team aims to containerize various applications following a recent meeting with the application development team. They intend to conduct testing with the following steps:


Install docker-ce and docker compose packages on App Server 3.


Initiate the docker service.

## Steps to Install Docker and Start Docker Service
1. **Update the Package Index**: Before installing Docker, it's essential to update the package index on your server to ensure you have access to the latest versions of packages and their dependencies.

```bash
sudo apt-get update
```
2. **Install Docker CE & Compose**: Install the Docker Community Edition (CE) and Docker Compose packages using the following commands:
```bash
sudo apt-get install -y docker-ce
sudo apt-get install -y docker-compose
```
3. **Start & Enable Docker Service**: 
```bash
sudo systemctl start docker
sudo systemctl enable docker
```
4. **Verify Docker & Compose Installation**:
```bash
sudo docker --version
sudo docker-compose --version
```