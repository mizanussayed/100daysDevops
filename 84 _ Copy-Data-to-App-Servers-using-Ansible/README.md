# Day 84: Copy Data to App Servers using Ansible

## 🎯 task

a. Create an inventory file /home/thor/ansible/inventory on jump_host and add all application servers as managed nodes.


b. Create a playbook /home/thor/ansible/playbook.yml on the jump host to copy the /usr/src/devops/index.html file to all application servers, placing it at /opt/devops.

## 🧑‍💻 solution

### Step 1: Create Inventory File
On the jump host, create the inventory file at /home/thor/ansible/inventory with the following content:

```ini
[app_servers]
stapp01 ansible_host=stapp01 ansible_user=tony ansible_password=Ir0nM@n
stapp02 ansible_host=stapp02 ansible_user=steve ansible_password=Am3ric@
stapp03 ansible_host=stapp03 ansible_user=banner ansible_password=BigGr33n
```
### Step 2: Create Playbook
Next, create the playbook at /home/thor/ansible/playbook.yml with the
following content:

```yaml
---
- name: Copy index.html to application servers
  hosts: app_servers
  become: yes
  tasks:
    - name: Copy index.html to /opt/devops
      copy:
        src: /usr/src/devops/index.html
        dest: /opt/devops/index.html
        owner: root
        group: root
        mode: '0644'
```