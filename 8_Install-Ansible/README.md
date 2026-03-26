# Day 8: Install Ansible
### task:
- Install ansible version 4.9.0 on server " Jump host" using pip3 only.
-  Make sure Ansible binary is available globally on this system, i.e all users on this system are able to run Ansible commands.

### Solution:
1. First, we need to install pip3 if it's not already installed. We can do this using the package manager for our operating system. For example, on a Debian-based system, we can run:
   
```bash
sudo apt update
sudo apt install python3-pip -y
```
2. Install Ansible. We will specify the version we want to install (4.9.0) using the `==` operator:

```bash
sudo pip3 install ansible==4.9.0
```
3. After the installation is complete, we can verify that Ansible is installed and available globally by running:
```bash
ansible --version
python3 -m pip show ansible || pip3 show ansible
```

