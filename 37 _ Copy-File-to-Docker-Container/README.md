# Day 37: Copy File to Docker Container

## 🎯 task
The Nautilus DevOps team possesses confidential data on App Server 3 in the Stratos Datacenter. A container named `ubuntu_latest` is running on the same server.


Copy an encrypted file `/tmp/nautilus.txt.gpg` from the docker host to the `ubuntu_latest` container located at `/usr/src/`. Ensure the file is not modified during this operation.

## Steps to Copy File to Docker Container

1. **Copy the File**: Once you have the Container ID, you can copy the file from the docker host to the container using the `docker cp` command:

```bash
docker cp /tmp/nautilus.txt.gpg <container_id>:/usr/src/
```
2. **Verify the File**: Finally, verify that the file has been copied correctly by accessing the container and checking its location:
```bash
docker exec -it <container_id> ls -l /usr/src/nautilus.txt.gpg
```
