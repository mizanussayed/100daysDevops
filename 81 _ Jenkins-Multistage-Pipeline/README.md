# Day 81: Jenkins Multistage Pipeline

## 🎯 task

There is a repository named sarah/web in Gitea that is already cloned on App Server 1 under /var/www/html directory.

1. Update the content of the file index.html under the same repository to Welcome to xFusionCorp Industries and push the changes to the origin into the master branch.

2. Add App Server 1 as a Jenkins agent (slave) node: name App Server 1, label stapp01, remote root directory `/home/sarah/jenkins_agent`, launch via SSH with host stapp01 and credentials for user sarah. Install java-17-openjdk on App Server 1 if needed.

3. Create a Jenkins pipeline job named deploy-job (it must not be a Multibranch pipeline job) and pipeline should have two stages Deploy and Test ( names are case sensitive ). Configure these stages as per details mentioned below.

    a. The Deploy stage should deploy the code from web repository under /var/www/html on App Server 1, as this is the document root of the app server.

    b. The pipeline should run on the App Server 1 node (e.g. use label stapp01).

    c. The Test stage should just test if the app is working fine and website is accessible. Its up to you how you design this stage to test it out, you can simply add a curl command as well to run a curl against the LBR URL (https://8091-port-k7ecpvcxspvoouzt.labs.kodekloud.com/) to see if the website is working or not. Make sure this stage fails in case the website/app is not working or if the Deploy stage fails.

## 🧑‍💻 solution
1. install java-17-openjdk on App Server 1 if needed.

```bash
echo "Welcome to xFusionCorp Industries" > index.html
git add index.html
git commit -m "Update welcome message"
git push origin master
sudo yum install java-17-openjdk java-17-openjdk-devel -y
sudo visudo
sarah ALL=(ALL) NOPASSWD: /bin/systemctl restart httpd
```

2. Install **SSH Build Agents** and **Pipeline** plugin in Jenkins and add App Server 1 as a Jenkins agent (slave) node.


2. Create a Jenkins pipeline job named deploy-job and configure (curl ok status) the pipeline as below: 

```groovy
pipeline {
    agent { label 'stapp01' }
    stages {
        stage('Deploy') {
            steps {
                sh '''
                cp /var/www/html/
                git pull origin master
                sudo systemctl restart httpd
                '''
            }
        }
        stage('Test') {
            steps {
                sh '''
                #!/bin/bash
                if curl -o /dev/null -s -w "%{http_code}\n" https://8091-port-eomohu3x2la4u7gh.labs.kodekloud.com/ | grep "200"
                then
                    echo "Website is working fine."
                else
                    echo "Website is not accessible."
                    exit 1
                fi
                '''
            }
        }
    }
}
```