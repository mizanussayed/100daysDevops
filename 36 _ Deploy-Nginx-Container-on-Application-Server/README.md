# Day 36: Deploy Nginx Container on Application Server

## Objective
The Nautilus DevOps team is conducting application deployment tests on selected application servers. They require a nginx container deployment on Application Server 3. Complete the task with the following instructions:
 - create a container named nginx_3 
 - using the nginx image with the alpine tag.
 - Ensure container is in a running state.

## Steps to Deploy Nginx Container
1. Pull the nginx image with the alpine tag from Docker Hub:
```bash
docker pull nginx:alpine
```
2. Create and run the nginx container with the name nginx_3 & check if it is running:
```bash
docker run -d --name nginx_3 nginx:alpine
docker ps
```