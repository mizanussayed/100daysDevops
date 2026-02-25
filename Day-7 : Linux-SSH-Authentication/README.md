# Day 7: Linux SSH Authentication

### Task:
Password-less SSH access to all app servers through their respective sudo users (i.e tony for app server 1). Based on the requirements, perform the following:

Set up a password-less authentication from user thor on jump host to all app servers through their respective sudo users.

### Solution:
1. Generate SSH key pair for the user thor on the jump host:
```bash 
ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -N ""
```
This command generates a new RSA key pair with a key size of 2048 bits and saves it to the specified file. The `-N ""` option sets an empty passphrase for the key.

2. Copy the public key to each app server for the respective sudo users:
```bash ssh-copy-id -i ~/.ssh/id_rsa.pub tony@app_server_1
ssh-copy-id -i ~/.ssh/id_rsa.pub steve@app_server_2
```
This command copies the public key to the authorized_keys file of the respective sudo users on each app
server. Replace `app_server_1`, `app_server_2`, and `app_server_3` with the actual hostnames or IP addresses of the app servers.
3. Verify the password-less SSH access:
```bash ssh tony@app_server_1
ssh steve@app_server_2
```