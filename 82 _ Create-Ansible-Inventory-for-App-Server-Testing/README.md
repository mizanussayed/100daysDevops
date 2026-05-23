# Day 82: Create Ansible Inventory for App Server Testing

## 🎯 task
a. Create an ini type Ansible inventory file /home/thor/playbook/inventory on jump host.

b. Include `App Server 1` in this inventory along with necessary variables for proper functionality.

c. Ensure the inventory hostname corresponds to the server name as per the wiki, for example `stapp01` for `App Server 1` in Stratos DC.

Note: Validation will execute the playbook using the command `ansible-playbook -i inventory playbook.yml`. 
Ensure the playbook functions properly without any extra arguments.


## 📝 solution
1. Log in to the jump host.
2. Navigate to the directory where you want to create the inventory file, for example:
```bash
cd /home/thor/playbook
```

3. Create the inventory file using a text editor, for example:
```bash
nano inventory
```
4. Add the following content to the inventory file, ensuring to replace the variables with the appropriate values for `App Server 1`:
```ini
[app_servers]
stapp01 ansible_host=<IP_ADDRESS> ansible_user=your_username ansible_ssh_private_key_file=/path/to/your/private/key
```

5. Alternatively, you can create the inventory file using the `cat` command:
```bash
cat > /home/thor/playbook/inventory <<EOF
[app_servers]
stapp01 ansible_host=stapp01 ansible_user=tony ansible_ssh_pass='Ir0nM@n'
EOF
```

6. Save the file and exit the editor.
7. Validate the inventory by running the following command:
```bash
ansible-playbook -i inventory playbook.yml
```


