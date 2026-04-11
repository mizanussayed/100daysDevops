# Day 43: Docker Ports Mapping

## Objective
The Nautilus DevOps team is planning to host an application on a nginx-based container. There are number of tickets already been created for similar tasks. One of the tickets has been assigned to set up a nginx container on Application Server 1 in Stratos Datacenter. Please perform the task as per details mentioned below:


a. Pull nginx:alpine-perl docker image on Application Server 1.

b. Create a container named apps using the image you pulled.

c. Map host port 8087 to container port 80. Please keep the container in running state.

## Steps to Perform
```bash
# Step 1: Pull the nginx:alpine-perl image
docker pull nginx:alpine-perl
# Step 2: Create and run the container with port mapping
docker run -d --name apps -p 8087:80 nginx:alpine-perl
# Step 3: Verify the container is running and ports are mapped
docker ps
```