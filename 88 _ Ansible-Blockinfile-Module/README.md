# Day 88: Ansible Blockinfile Module

## 🎯 task
We already have an inventory file under /home/thor/ansible directory on jump host. Create a playbook.yml under /home/thor/ansible directory on jump host itself.


1. Using the playbook, install httpd web server on all app servers. Additionally, make sure its service should up and running.


2. Using `blockinfile` Ansible module add some content in /var/www/html/index.html file. Below is the content:

```txt
Welcome to XfusionCorp!
This is  Nautilus sample file, created using Ansible!
Please do not modify this file manually!
```

3. The /var/www/html/index.html file's user and group owner should be apache on all app servers.

4. The /var/www/html/index.html file's permissions should be 0744 on all app servers.

Note:

i. Validation will try to run the playbook using command `ansible-playbook -i inventory playbook.yml` so please make sure the playbook works this way without passing any extra arguments.

ii. Do not use any custom or empty marker for `blockinfile` module.

## 🧑‍💻 Solution


```yaml
---
- name: Configure Apache HTTPD and Index File
  hosts: all
  become: yes
  tasks:

    - name: Install httpd package
      yum:
        name: httpd
        state: present

    - name: Start and enable httpd service
      service:
        name: httpd
        state: started
        enabled: yes

    - name: Ensure index.html file exists
      file:
        path: /var/www/html/index.html
        state: touch
        owner: apache
        group: apache
        mode: '0744'

    - name: Add content to index.html using blockinfile
      blockinfile:
        path: /var/www/html/index.html
        block: |
          Welcome to XfusionCorp!
          This is  Nautilus sample file, created using Ansible!
          Please do not modify this file manually!
        owner: apache
        group: apache
        mode: '0744'
```
