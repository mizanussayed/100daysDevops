# Day 3: Secure Root SSH Access

## 🎯 task
Following security audits, the xFusionCorp Industries security team has rolled out new protocols, including the restriction of direct root SSH login.

- task is to disable direct SSH root login on all app servers within the Stratos Datacenter.

## Commands Used
```bash
# Edit the SSH configuration file
sudo vi /etc/ssh/sshd_config
# Find the line that says "PermitRootLogin" and change its value to "no"
PermitRootLogin no

# Restart the SSH service to apply the changes
sudo systemctl restart sshd
```
## validate the changes by attempting to SSH into the server as root
```bash
ssh root@your_server_ip
```

## varify the Setting 
```bash sudo sshd -T | grep permitrootlogin
# output should be:
permitrootlogin no
```

