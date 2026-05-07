# Day 68: Set Up Jenkins Server

## 🎯 task
1. Install Jenkins on the jenkins server using the apt utility only, and start it using the service command.

If you face a timeout issue while starting the Jenkins service, first check the service status with service jenkins status
Then review the logs in /var/log/jenkins/jenkins.log to identify the cause.
2. Jenkin's admin user name should be theadmin, password should be Adm!n321, full name should be Ravi and email should be ravi@jenkins.stratos.xfusioncorp.com.


Note:

1. To access the jenkins server, connect from the jump host using the root user with the password S3curePass.

2. After Jenkins server installation, click the Jenkins button on the top bar to access the Jenkins UI and follow on-screen instructions to create an admin user.


## 🧑‍💻 solution

```bash
# install jenkins
sudo apt update
sudo apt install jenkins -y
sudo service jenkins start



# access jenkins UI and create admin user with the following details:
# username: theadmin
# password: Adm!n321
# full name: Ravi
# email: ravi@jenkins.stratos.xfusioncorp.com
```
