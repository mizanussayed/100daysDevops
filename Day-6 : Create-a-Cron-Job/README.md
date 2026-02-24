# Day 6: Create a Cron Job

### Task:
a. Install cronie package and start crond service.
b. Add a cron */5 * * * * echo hello > /tmp/cron_text for root user.
### Solution:

a. To install the cronie package and start the crond service, you can use the following commands:
```bash
sudo yum install -y cronie
sudo systemctl start crond
sudo systemctl enable crond
```

b. To add the cron job for the root user, you can use the following command:
```bash 
echo "*/5 * * * * echo hello > /tmp/cron_text" | sudo crontab -u root -
```
This command installs the cron job in root's crontab. The cron job will execute every 5 minutes and write "hello" to the file /tmp/cron_text.

To verify it is present:
```bash
sudo crontab -u root -l
```
