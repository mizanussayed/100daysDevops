# Day 19: Install and Configure Web Application

xFusionCorp Industries is planning to host two static websites on their infra in Stratos Datacenter. The development of these websites is still in-progress, but we want to get the servers ready. Please perform the following steps to accomplish the task:


- a. Install httpd package and dependencies on app server 1.


- b. Apache should serve on port 3001.

- c. There are two website's backups /home/thor/blog and /home/thor/games on jump_host. Set them up on Apache in a way that blog should work on the link http://localhost:3001/blog/ and games should work on link http://localhost:3001/games/ on the mentioned app server.

- d. Once configured you should be able to access the website using curl command on the respective app server, i.e curl http://localhost:3001/blog/ and curl http://localhost:3001/games/


## Solution
1. First, we need to install the httpd package and its dependencies on app server 1. We can do this using the following command:

```bash
sudo yum install httpd -y
```
2. Next, we need to configure Apache to serve on port 3001. We can do this by editing the Apache configuration file. Open the file using a text editor:

```bash
sudo vi /etc/httpd/conf/httpd.conf
```
Find the line that says "`Listen 80`" and change it to "`Listen 3001`". Save and exit the file.
3. Now, we need to set up the two websites using the backups provided. We can create two directories for the websites in the Apache document root:

```bash
sudo mkdir -p /var/www/html/blog
sudo mkdir -p /var/www/html/games
```
Next, we need to copy the backup files from the jump_host to the respective directories on app server 1. We can use the scp command to do this:
```bash
scp thor@jump_host:/home/thor/blog/* /var/www/html/blog/
scp thor@jump_host:/home/thor/games/* /var/www/html/games/
```
4. After copying the files, we need to set the correct permissions for the Apache user to access the files:
```bash
sudo chown -R apache:apache /var/www/html/blog
sudo chown -R apache:apache /var/www/html/games
```
5. Finally, we need to restart the Apache service to apply the changes:
```bash
sudo systemctl restart httpd
```

## verification
To verify that the websites are working correctly, we can use the curl command to access the respective
websites:
```bash
curl http://localhost:3001/blog/
curl http://localhost:3001/games/
```


