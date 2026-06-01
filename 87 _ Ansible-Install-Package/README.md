# Day 87: Ansible Install Package

## 🎯 task
1. Create an inventory file /home/thor/playbook/inventory on jump host and add all app servers in it.


2. Create an Ansible playbook /home/thor/playbook/playbook.yml to install `samba` package on all  app servers using Ansible yum module.


3. Make sure user thor should be able to run the playbook on jump host.

## 🧑‍💻 Solution
1. Create an inventory file /home/thor/playbook/inventory on jump host and add all app servers in it.

```bash
echo -e "[app_servers]\napp1 ansible_host=10.0.1.10\napp2 ansible_host=10.0.1.11\napp3 ansible_host=10.0.1.12" > /home/thor/playbook/inventory
```

2. Create an Ansible playbook /home/thor/playbook/playbook.yml to install `samba` package on all  app servers using Ansible yum module.

```yaml
---
- hosts: app_servers
  become: yes
  tasks:
    - name: Install samba package
      yum:
        name: samba
        state: present
```

3. Make sure user thor should be able to run the playbook on jump host.

```bash
#if needed give necessary permissions to run Ansible playbooks
sudo usermod -aG wheel thor 
# Run the playbook to install samba on all app servers
ansible-playbook -i /home/thor/playbook/inventory /home/thor/playbook/playbook.yml
```