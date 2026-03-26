# Day 11: Install and Configure Tomcat Server

### task:
a. Install tomcat server on App Server 2.

b. Configure it to run on port 6200.

c. There is a ROOT.war file on Jump host at location /tmp.

d. Deploy it on this tomcat server and make sure the webpage works directly on base URL i.e curl http://stapp02:6200

### Solution
1. Install Tomcat on App Server 2 (CentOS/RHEL):
```bash
sudo yum install -y tomcat
```

2. Configure Tomcat to run on port 6200:
```bash
sudo sed -i 's/port="8080"/port="6200"/' /usr/share/tomcat/conf/server.xml
```

3. Restart Tomcat and verify listener:
```bash
sudo systemctl restart tomcat
sudo systemctl status tomcat --no-pager
sudo ss -ltnp | grep 6200
```

5. Copy ROOT.war from jump host to App Server 2:
```bash
scp /tmp/ROOT.war steve@stapp02:/tmp/
```

6. Deploy ROOT.war to the Tomcat webapps directory:
```bash
sudo mv /tmp/ROOT.war /usr/share/tomcat/webapps/
sudo systemctl restart tomcat
```

7. Verify application response:
```bash
curl -4 -I http://127.0.0.1:6200
curl http://stapp02:6200
```

### Troubleshooting
- If `curl http://localhost:6200` gives `Recv failure: Connection reset by peer`, check localhost resolution:
```bash
getent hosts localhost
```

- If `localhost` resolves only to `::1`, test with IPv4:
```bash
curl -4 -I http://localhost:6200
curl -I http://127.0.0.1:6200
```

- Optional firewall rule (only when `firewalld` is installed and active):
```bash
sudo systemctl is-active firewalld
sudo firewall-cmd --add-port=6200/tcp --permanent
sudo firewall-cmd --reload
```

