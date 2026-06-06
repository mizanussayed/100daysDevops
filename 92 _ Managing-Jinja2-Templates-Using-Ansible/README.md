# Day 92: Managing Jinja2 Templates Using Ansible

## 🎯 task
One of the Nautilus DevOps team members is working on to develop a role for httpd installation and configuration. Work is almost completed, however there is a requirement to add a jinja2 template for index.html file. Additionally, the relevant task needs to be added inside the role. The inventory file ~/ansible/inventory is already present on jump host that can be used. Complete the task as per details mentioned below:


a. Update ~/ansible/playbook.yml playbook to run the httpd role on App Server 2.


b. Create a jinja2 template index.html.j2 under /home/thor/ansible/role/httpd/templates/ directory and add a line This file was created using Ansible on <respective server> (for example This file was created using Ansible on stapp01 in case of App Server 1). Also please make sure not to hard code the server name inside the template. Instead, use inventory_hostname variable to fetch the correct value.


c. Add a task inside /home/thor/ansible/role/httpd/tasks/main.yml to copy this template on App Server 2 under /var/www/html/index.html. Also make sure that /var/www/html/index.html file's permissions are 0755.


d. The user/group owner of /var/www/html/index.html file must be respective sudo user of the server (for example tony in case of stapp01).

## 🧑‍💻 solution

### playbook.yml
```yaml
---
- hosts: stapp02
  become: yes
  become_user: root
  roles:
    - role: httpd
```

### index.html.j2
```html
 echo "This file was created using Ansible on {{ inventory_hostname }}" > /home/thor/ansible/role/httpd/templates/index.html.j2
```

### update main.yml
 /home/thor/ansible/role/httpd/tasks/main.yml
```yaml
---
# tasks file for role/test
- name: install the latest version of HTTPD
  yum:
    name: httpd
    state: latest

- name: Start service httpd
  service:
    name: httpd
    state: started

## added below task to copy jinja2 template
- name: Deploy index.html from template
  template:
    src: index.html.j2
    dest: /var/www/html/index.html
    owner: steve
    group: steve
    mode: '0755'
```


## verification

```bash
ansible-playbook -i ~/ansible/inventory ~/ansible/playbook.yml
ansible stapp02 -i inventory -m shell -a "cat /var/www/html/index.html"
ansible stapp02 -i inventory -m shell -a "ls -l /var/www/html/index.html"
```


