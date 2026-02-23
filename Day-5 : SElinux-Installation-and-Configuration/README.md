# Day 5: SELinux Installation and Configuration

## What is SELinux?
Security-Enhanced Linux (SELinux) is a security module that controls which users and processes can access specific files, directories, and resources, helping to prevent unauthorized access and mitigate potential security vulnerabilities.

## Task:
1. Install the required SELinux packages.
2. Permanently disable SELinux for the time being; it will be re-enabled after necessary configuration changes.

## Solution:
1. To install the required SELinux packages on CentOS, run the appropriate command for your version:
```bash
# CentOS 8/9
sudo dnf install -y selinux-policy-targeted policycoreutils policycoreutils-python-utils

# debian/ubuntu
sudo apt-get install -y selinux-basics selinux-policy-default auditd
```
2. To permanently disable SELinux, edit the SELinux configuration file:
```bash
sudo vi /etc/selinux/config
```
3. Change the line `SELINUX=enforcing` to `SELINUX=disabled` and save the file.
4. To check the current status of SELinux, you can run the following command:
```bash 
sestatus
```
5. After making these changes, you will need to reboot your system for the changes to take effect:
```bash
sudo reboot
```