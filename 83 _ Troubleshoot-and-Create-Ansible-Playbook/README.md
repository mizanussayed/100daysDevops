# Day 83: Troubleshoot and Create Ansible Playbook

## 🎯 task
1. The inventory file /home/thor/ansible/inventory requires adjustments. The playbook must run on App Server 2 in Stratos DC. Update the inventory accordingly.

2. Create a playbook /home/thor/ansible/playbook.yml. Include a task to create an empty file /tmp/file.txt on App Server 2.


## before inventory file
```
stapp03 ansible_user=banner ansible_ssh_pass=$pwd ansible_ssh_common_args='-o StrictHostKeyChecking=no'
```
### after fixing inventory file
```
stapp02 ansible_user=steve ansible_ssh_pass=Am3ric@ ansible_ssh_common_args='-o StrictHostKeyChecking=no'
```

## playbook.yml
```yaml
---
- name: Create an empty file on App Server 2
  hosts: stapp02
  tasks:
    - name: Create an empty file /tmp/file.txt
      file:
        path: /tmp/file.txt
        state: touch
```