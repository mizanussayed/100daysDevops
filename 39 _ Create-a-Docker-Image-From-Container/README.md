# Day 39: Create a Docker Image From Container

## 🎯 task
One of the Nautilus developer was working to test new changes on a container. He wants to keep a backup of his changes to the container. A new request has been raised for the DevOps team to create a new image from this container. Below are more details about it:


a. Create an image cluster:devops on Application Server 1 from a container ubuntu_latest that is running on same server.

## Solution
To create a Docker image from a running container, you can use the `docker commit` command. Below are the steps to achieve this:
1. First, you need to find the container ID of the running container `ubuntu_latest`. You can do this by running the following command:
```bash
docker ps
docker commit <container_id> cluster:devops
 ```
Replace `<container_id>` with the actual ID of the running container `ubuntu_latest`.

2. Verify that the new image has been created:

```bash
docker images
```
