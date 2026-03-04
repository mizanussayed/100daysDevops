# Day 14: Linux Process Troubleshooting

The production support team of xFusionCorp Industries has deployed some of the latest monitoring tools to keep an eye on every service, application, etc. running on the systems. One of the monitoring systems reported about Apache service unavailability on one of the app servers in Stratos DC.

Identify the faulty app host and fix the issue. Make sure Apache service is up and running on all app hosts. They might not have hosted any code yet on these servers, so you don’t need to worry if Apache isn’t serving any pages. Just make sure the service is up and running. Also, make sure Apache is running on port 8084 on all app servers.

## Solution:
1. Check the status of Apache service on both app servers:
```bash
sudo systemctl status httpd
```
2. If Apache is not running, start the service:
```bash
sudo systemctl start httpd
```
3. Check if Apache is listening on port 8084:
```bash
sudo netstat -tuln | grep 8084
```
4. If Apache is not listening on port 8084, edit the Apache configuration file to
change the listening port:
```bash
sudo vi /etc/httpd/conf/httpd.conf
```
Find the line that says `Listen 80` and change it to `Listen 8084
5. Save the file and restart Apache service:
```bash
sudo systemctl restart httpd
```
6. Verify that Apache is now listening on port 8084:
```bash
sudo netstat -tuln | grep 8084
```