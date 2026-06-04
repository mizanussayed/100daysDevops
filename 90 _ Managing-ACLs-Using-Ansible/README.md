# Day 90: Managing ACLs Using Ansible

## 🎯 task
1. Create a playbook named playbook.yml under /home/thor/ansible directory on jump host, an inventory file is already present under /home/thor/ansible directory on Jump Server itself.


2. Create an empty file blog.txt under /opt/sysops/ directory on app server 1. Set some acl properties for this file. Using acl provide read '(r)' permissions to group tony (i.e entity is tony and etype is group).


3. Create an empty file story.txt under /opt/sysops/ directory on app server 2. Set some acl properties for this file. Using acl provide read + write '(rw)' permissions to user steve (i.e entity is steve and etype is user).


4. Create an empty file media.txt under /opt/sysops/ on app server 3. Set some acl properties for this file. Using acl provide read + write '(rw)' permissions to group banner (i.e entity is banner and etype is group).

## 🧑‍💻 solution
```yaml
---
- name: Configure ACLs on App Server 1
  hosts: app_server_1
  become: true

  tasks:
    - name: Create blog.txt
      file:
        path: /opt/sysops/blog.txt
        state: touch

    - name: Give read permission to group tony
      acl:
        path: /opt/sysops/blog.txt
        entity: tony
        etype: group
        permissions: r
        state: present

- name: Configure ACLs on App Server 2
  hosts: app_server_2
  become: true

  tasks:
    - name: Create story.txt
      file:
        path: /opt/sysops/story.txt
        state: touch

    - name: Give read/write permission to user steve
      acl:
        path: /opt/sysops/story.txt
        entity: steve
        etype: user
        permissions: rw
        state: present

- name: Configure ACLs on App Server 3
  hosts: app_server_3
  become: true

  tasks:
    - name: Create media.txt
      file:
        path: /opt/sysops/media.txt
        state: touch

    - name: Give read/write permission to group banner
      acl:
        path: /opt/sysops/media.txt
        entity: banner
        etype: group
        permissions: rw
        state: present
```