# Day 12: Linux Network Services
## taks:
Our monitoring tool has reported an issue in Stratos Datacenter. One of our app servers has an issue, as its Apache service is not reachable on port 8082 (which is the Apache port). The service itself could be down, the firewall could be at fault, or something else could be causing the issue.

Use tools like telnet, netstat, etc. to find and fix the issue. Also make sure Apache is reachable from the jump host without compromising any security settings.

Once fixed, you can test the same using command curl http://stapp01:8082 command from jump host.

## solution: centos/RHEL
1. Check if Apache is running or enabled:
```bash
sudo systemctl is-active httpd
sudo systemctl is-enabled httpd
sudo systemctl status httpd --no-pager
```
2. If not running, start Apache:
```bash
sudo systemctl start httpd
```
3. Check if Apache is listening on port 8082:
```bash
sudo netstat -tulnp | grep 8082
# or
sudo telnet localhost 8082
```
4. If not listening, check Apache configuration for the correct port:
```bash
sudo grep -i 'listen' /etc/httpd/conf/httpd.conf
```
5. if other service is using port 8082, stop that service and disable it if not needed:
```bash
sudo ss -ltnp | grep 8082
sudo kill <pid>
```

5. If the port is correct, check firewall rules:
```bash
sudo iptables -L -n
```
6. If port 8082 is blocked, add a rule to allow traffic:
```bash
sudo iptables -A INPUT -p tcp --dport 8082 -j ACCEPT
sudo service iptables save
```

7. Verify Apache is reachable from the jump host:
```bash
curl http://stapp01:8082
```
## 


