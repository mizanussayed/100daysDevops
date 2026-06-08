# Day 93: Using Ansible Conditionals

## 🎯 task
1. Create a playbook /home/thor/ansible/playbook.yml and make sure to use Ansible's when conditionals statements to perform the below given tasks.


2. Copy blog.txt file present under /usr/src/itadmin directory on jump host to App Server 1 under /opt/itadmin  directory. Its user and group owner must be user tony and its permissions must be 0744  .


3. Copy story.txt file present under /usr/src/itadmin directory on jump host to App Server 2 under /opt/itadmin directory. Its user and group owner must be user steve and its permissions must be 0744  .


4. Copy media.txt file present under /usr/src/itadmin directory on jump host to App Server 3 under /opt/itadmin directory. Its user and group owner must be user banner and its permissions must be 0744.

## 🧑‍💻 solution
```yaml
---
- name: Using Ansible Conditionals
  hosts: all
  become: true

  tasks:
    - name: Copy blog.txt to App Server 1
      copy:
        src: /usr/src/itadmin/blog.txt
        dest: /opt/itadmin/blog.txt
        owner: tony
        group: tony
        mode: '0744'
      when: inventory_hostname == 'stapp01'

    - name: Copy story.txt to App Server 2
      copy:
        src: /usr/src/itadmin/story.txt
        dest: /opt/itadmin/story.txt
        owner: steve
        group: steve
        mode: '0744'
      when: inventory_hostname == 'stapp02'

    - name: Copy media.txt to App Server 3
      copy:
        src: /usr/src/itadmin/media.txt
        dest: /opt/itadmin/media.txt
        owner: banner
        group: banner
        mode: '0744'
      when: inventory_hostname == 'stapp03'
```
## verification
1. Run the playbook and verify the files are copied with correct ownership and permissions on respective servers.

```bash
ansible-playbook /home/thor/ansible/playbook.yml
ansible stapp01 -m stat -a "path=/opt/itadmin/blog.txt"
```



## Simplified Version
```yaml
---
- name: Using Ansible Conditionals
  hosts: all
  become: true

  vars:
    file_map:
      stapp01: blog.txt
      stapp02: story.txt
      stapp03: media.txt

  tasks:
    - name: Copy appropriate file
      copy:
        src: "/usr/src/itadmin/{{ file_map[inventory_hostname] }}"
        dest: "/opt/itadmin/{{ file_map[inventory_hostname] }}"
        owner: "{{ owner_name }}"
        group: "{{ owner_name }}"
        mode: '0744'
```
