# Day 86: Ansible Ping Module Usage

## 🎯task

a. Jump host is our Ansible controller, and we are going to run Ansible playbooks through thor user from jump host.

b. There is an inventory file /home/thor/ansible/inventory on jump host. Using that inventory file test Ansible ping from jump host to App Server 3, make sure ping works.


## 🧑‍💻 solution

### Step 1: Test Ansible Ping
On the jump host, run the following command to test Ansible ping to App Server 3:

```bash
# Add App Server 3 to known hosts
ssh-keyscan -H stapp03 >> ~/.ssh/known_hosts
# Test ping to App Server 3
ansible -i /home/thor/ansible/inventory stapp03 -m ping
# Test ping to all hosts
ansible -i /home/thor/ansible/inventory all -m ping
```
