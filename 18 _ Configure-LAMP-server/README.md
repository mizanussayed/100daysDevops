# Day 18: Configure LAMP server

We need to setup a database server on Nautilus DB Server in Stratos Datacenter. Please perform the below given steps on DB Server:

a. Install/Configure MariaDB server.

b. Create a database named kodekloud_db7.

c. Create a user called kodekloud_top and set its password to ksH85UJjhb.

d. Grant full permissions to user kodekloud_top on database kodekloud_db7.

```bash
#!/bin/bash

# Install MariaDB server
sudo yum install -y mariadb-server

# Start and enable MariaDB
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Configure database, user, and permissions
sudo mysql <<EOF
CREATE DATABASE kodekloud_db7;
CREATE USER 'kodekloud_top'@'%' IDENTIFIED BY 'ksH85UJjhb';
GRANT ALL PRIVILEGES ON kodekloud_db7.* TO 'kodekloud_top'@'%';
FLUSH PRIVILEGES;
EXIT;
EOF
```
## Change the permissions of the script and execute it:
```bash
chmod +x setup_mariadb.sh
./setup_mariadb.sh
```
## Verify the database, user, and permissions:
```bash
SHOW DATABASES;

SELECT User, Host FROM mysql.user;
SHOW GRANTS FOR 'root'@'localhost';
SHOW GRANTS FOR 'username'@'localhost';


MariaDB [(none)]> SELECT User, Host FROM mysql.user;
+---------------+-----------+
| User          | Host      |
+---------------+-----------+
| kodekloud_top | %         |   # any host
| mariadb.sys   | localhost |
| mysql         | localhost |
| root          | localhost |
+---------------+-----------+
4 rows in set (0.001 sec)
``` 