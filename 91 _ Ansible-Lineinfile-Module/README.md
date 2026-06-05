# Day 91: Ansible Lineinfile Module

## 🎯 task
1. Install httpd web server on all app servers, and make sure its service is up and running.

2. Create a file /var/www/html/index.html with content:

3. This is a Nautilus sample file, created using Ansible!

4. Using lineinfile Ansible module add some more content in /var/www/html/index.html file. Below is the content:

`Welcome to xFusionCorp Industries!`

Also make sure this new line is added at the top of the file.

5. The /var/www/html/index.html file's user and group owner should be apache on all app servers.

6. The /var/www/html/index.html file's permissions should be 0644 on all app servers.

## 🧑‍💻 solution

### playbook.yaml
```yaml
- name: Install httpd and create index.html
  hosts: all
  become: yes

  tasks:
    - name: Install httpd web server
      yum:
        name: httpd
        state: present

    - name: Start and enable httpd service
      service:
        name: httpd
        state: started
        enabled: yes

    - name: Create index.html with initial content
      copy:
        dest: /var/www/html/index.html
        content: "This is a Nautilus sample file, created using Ansible!\n"
        owner: apache
        group: apache
        mode: '0644'

    - name: Add additional content to index.html at the top of the file
      lineinfile:
        path: /var/www/html/index.html
        line: "Welcome to xFusionCorp Industries!"
        insertbefore: BOF
        owner: apache
        group: apache
        mode: '0644'
``` 