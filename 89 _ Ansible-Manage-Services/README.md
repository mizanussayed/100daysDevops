# Day 89: Ansible Manage Services

## 🎯 task

a. On jump host create an Ansible playbook /home/thor/ansible/playbook.yml and configure it to install httpd on all app servers.

b. After installation make sure to start and enable httpd service on all app servers.

c. The inventory /home/thor/ansible/inventory is already there on jump host.

## 🧑‍💻 Solution

### playboo.yml
```yml
---
- name: Install and configure Apache HTTP Server
  hosts: all
  become: yes
  tasks:
    - name: Install httpd package
      ansible.builtin.yum: ## FQDN
        name: httpd
        state: present

    - name: Start and enable httpd service
      ansible.builtin.service:
        name: httpd
        state: started
        enabled: yes
```


