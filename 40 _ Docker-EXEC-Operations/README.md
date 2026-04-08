# Day 40: Docker EXEC Operations

## Objective
One of the Nautilus DevOps team members was working to configure services on a kkloud container that is running on App Server 1 in Stratos Datacenter. Due to some personal work he is on PTO for the rest of the week, but we need to finish his pending work ASAP. Please complete the remaining work as per details given below:

a. Install apache2 in kkloud container using apt that is running on App Server 1 in Stratos Datacenter.
b. Configure Apache to listen on port 8084 instead of default http port. Do not bind it to listen on specific IP or hostname only, i.e it should listen on localhost, 127.0.0.1, container ip, etc.
c. Make sure Apache service is up and running inside the container. Keep the container in running state at the end.


## Steps to Follow
1. Connect to App Server 1 in Stratos Datacenter using SSH.
2. List all running containers to identify the container ID or name of the kkloud container
3. Use `docker exec` command to access the kkloud container's shell.
4. Update the package list and install apache2 using apt.
5. Modify the Apache configuration file to change the listening port to 8084.
6. Restart the Apache service to apply the changes.
7. Verify that Apache is running and listening on the new port.
8. Exit the container shell and ensure the container remains in a running state.

## Commands to Use
```bash
docker ps
docker exec -it <container_id_or_name> bash
# Step 2: Update package list and install apache2
apt update
apt install apache2 -y
sed -i 's/Listen 80/Listen 8084/' /etc/apache2/ports.conf
service apache2 restart
netstat -tuln | grep 8084
exit
```