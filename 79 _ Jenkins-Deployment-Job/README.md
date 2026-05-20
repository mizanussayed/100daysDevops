# Day 79: Jenkins Deployment Job

## 🎯 task
1. httpd is already installed and configured on the app server (listening on port 8080). Ensure the httpd service is running on App Server 1 (e.g. start it manually if needed). You can make starting/restarting httpd part of your Jenkins job if you prefer.


2. Create a Jenkins job named datacenter-app-deployment and configure it so that if anyone pushes any new change to the origin repository in master branch, the job should auto build and deploy the latest code on App Server 1 under /var/www/html directory.
Before deployment, ensure that the ownership of the /var/www/html directory is set to user sarah, so that Jenkins can successfully deploy files to that directory.


3. SSH into App Server 1 using sarah user credentials mentioned above. Under sarah user's home (/home/sarah/web) you will find a cloned Git repository named web. Under this repository there is an index.html file, update its content to Welcome to the xFusionCorp Industries, then push the changes to the origin into master branch. This push must trigger your Jenkins job and the latest changes must be deployed on the server, also make sure it deploys the entire repository content not only index.html file.

## 🧑‍💻 solution

**copy ssh-rsa-id from jenkins server to app server's ~/.ssh/authorized_keys**
```bash
ssh-copy-id sarah@stapp01
```
**change ownership of /var/www/html to sarah**
```bash
sudo chown -R sarah:sarah /var/www/html
```
**Jenkins pipeline configuration**
```groovy
pipeline {
    agent any
    triggers {
        pollSCM('H/5 * * * *') // Polls the SCM every 5 minutes
    }
    stages {
        stage('Deploy') {
            steps {
                sh 'ssh sarah@stapp01 "cd /var/www/html && git pull origin master && sudo systemctl restart httpd"'
            }
        }
    }
}
```

**update index.html content and push changes to origin**
```bash
cd /home/sarah/web
echo "Welcome to the xFusionCorp Industries" > index.html
git add index.html
git commit -m "Update index.html content"
git push origin master
```



