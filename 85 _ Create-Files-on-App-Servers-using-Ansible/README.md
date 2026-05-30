# Day 85: Create Files on App Servers using Ansible

## 🎯 task
a. Create an inventory file ~/playbook/inventory on jump host and include all app servers.

b. Create a playbook ~/playbook/playbook.yml to create a blank file /tmp/webapp.txt on all app servers.

c. Set the permissions of the /tmp/webapp.txt file to 0744.

d. Ensure the user/group owner of the /tmp/webapp.txt file is tony on app server 1, steve on app server 2 and banner on app server 3.

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
- name: Create and configure webapp.txt on application servers
  hosts: app_servers
  become: yes
  tasks:
    - name: Create blank file /tmp/webapp.txt
      file:
        path: /tmp/webapp.txt
        state: touch
        mode: '0744'
    - name: Set ownership of /tmp/webapp.txt
      file:
        path: /tmp/webapp.txt
        owner: "{{ ansible_user }}"
        group: "{{ ansible_user }}"
    # when: inventory_hostname == 'stapp01'
```


