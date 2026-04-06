# Day 38: Pull Docker Image

## Objective
Nautilus project developers are planning to start testing on a new project. As per their meeting with the DevOps team, they want to test containerized environment application features. As per details shared with DevOps team, we need to accomplish the following task:


a. Pull busybox:musl image on App Server 2 in Stratos DC and re-tag (create new tag) this image as busybox:news.

## Steps to Accomplish the Task
1. Pull the busybox:musl image from Docker Hub.
```bash
docker pull busybox:musl
```
2. Re-tag the pulled image as busybox:news.
```bash
docker tag busybox:musl busybox:news
```
3. Verify that the new tag has been created successfully.
```bash
docker images
```
