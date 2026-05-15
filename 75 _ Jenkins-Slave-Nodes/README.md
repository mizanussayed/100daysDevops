# Day 75: Jenkins Slave Nodes

## 🎯 task
1. Add all app servers as SSH build agent/slave nodes in Jenkins. Slave node name for app server 1, app server 2 and app server 3 must be App_server_1, App_server_2, App_server_3 respectively.


2. Add labels as below:

        App_server_1 : stapp01
        App_server_2 : stapp02
        App_server_3 : stapp03


3. Remote root directory for App_server_1 must be /home/tony/jenkins, for App_server_2 must be /home/steve/jenkins and for App_server_3 must be /home/banner/jenkins.


4. Make sure slave nodes are online and working properly.


## 🧑‍💻 solution


To configure the three app servers as SSH agent/slave nodes in Jenkins and ensure they are online, follow these steps on your Jenkins server.

## 1. Install Required Jenkins Plugins

In Jenkins:

* Go to **Manage Jenkins** → **Plugins**

  * **SSH Build Agents plugin** (or “SSH Slaves” depending on Jenkins version)

Restart Jenkins if required.

---

## 2. Prepare SSH Access from Jenkins Server

On the Jenkins server, generate SSH keys & copy them to the app servers:

```bash
ssh-keygen -t rsa -b 4096

ssh-copy-id tony@stapp01
ssh-copy-id steve@stapp02
ssh-copy-id banner@stapp03
```

---

## 3. Add Jenkins Credentials

In Jenkins:

* Go to **Manage Jenkins** → **Credentials**
* Add SSH credentials for:
* Kind: **SSH Username with private key**
* Username:

  * `tony`
  * `steve`
  * `banner`
* Private Key:

  * Enter directly or from Jenkins master `~/.ssh/id_rsa`

---

# 4. Create Agent Nodes

Go to:

**Manage Jenkins** → **Nodes** → **New Node**

Create the following one by one.

---

## Node 1

### Name

```text
App_server_1
```

### Configuration

* Type: Permanent Agent
* Remote root directory:

```text
/home/tony/jenkins
```

* Labels:

```text
stapp01
```

* Launch method:

  * **Launch agents via SSH**

### SSH Details

* Host:

```text
stapp01
```

* Credentials:

  * Select `tony` SSH credential

Save.

---

## Node 2, 3


# 5. Ensure Directories Exist on Remote Servers

Run:

```bash
ssh tony@stapp01 "mkdir -p /home/tony/jenkins"
ssh steve@stapp02 "mkdir -p /home/steve/jenkins"
ssh banner@stapp03 "mkdir -p /home/banner/jenkins"
```

---

# 6. Verify Agents Are Online

Go to:

```text
Manage Jenkins → Nodes
```

Each node should show:

```text
Connected
```

You can also click each node and verify:

* No launch errors
* Agent connected successfully
* Executors available

---

# 7. Test Build Execution

Create a simple Pipeline job:

```groovy
pipeline {
    agent { label 'stapp01' }

    stages {
        stage('Test') {
            steps {
                sh 'hostname'
            }
        }
    }
}
```

Repeat with:

* `stapp02`
* `stapp03`

to verify all nodes work correctly.

