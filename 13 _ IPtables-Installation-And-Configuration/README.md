# Day 13: IPtables Installation And Configuration
### taks:
- Our security team has raised a concern that right now Apache’s port i.e 5003 is open for all since there is no firewall installed on these hosts. So we have decided to add some security layer for these hosts and after discussions and recommendations we have come up with the following requirements:

1. Install iptables and all its dependencies on each app host.


2. Block incoming port 5003 on all apps for everyone except for LBR host.

3. Make sure the rules remain, even after system reboot.

## Solution:
1. Install iptables on App Server 1 and App Server 2 (CentOS/RHEL):
```bash
sudo yum install -y iptables-services
```
2. Configure iptables to block incoming port 5003 for everyone except LBR host (assuming LBR host IP is 172.16.238.14):
```bash
# Allow traffic from LBR host
sudo iptables -A INPUT -p tcp -s 172.16.238.14 -j ACCEPT
# Block all other traffic on port 5003
sudo iptables -A INPUT -p tcp --dport 5003 -j DROP
```

3. Save iptables rules and enable the service:
```bash
sudo service iptables save
sudo systemctl enable iptables
sudo systemctl start iptables
```
4. Verify iptables rules:
```bash
sudo iptables -L -n
```


```bash
sudo yum install -y iptables-services
sudo iptables -F

sudo iptables -A INPUT -p tcp -s 172.16.238.14 --dport 5003 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 5003 -j DROP

sudo service iptables save
sudo systemctl enable iptables
sudo systemctl start iptables

sudo iptables -L -n
```