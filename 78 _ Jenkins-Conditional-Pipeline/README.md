# Day 78: Jenkins Conditional Pipeline

## 🎯 task
1. Add a slave node named App Server 1. It should be labeled as stapp01 and its remote root directory should be /home/sarah/jenkins_agent (the repository is cloned under /var/www/html).

2. We have already cloned repository on App Server 1 under /var/www/html.


3. Apache is already installed on the app server and is running on port 8080.


4. Create a Jenkins pipeline job named datacenter-webapp-job (it must not be a Multibranch pipeline) and configure it to:

* Add a string parameter named BRANCH.

It should conditionally deploy the code from web_app repository under /var/www/html on App Server 1, as this is the document root of the app server. The pipeline should have a single stage named Deploy ( which is case sensitive ) to accomplish the deployment.

The pipeline should be conditional, if the value master is passed to the BRANCH parameter then it must deploy the master branch, on the other hand if the value feature is passed to the BRANCH parameter then it must deploy the feature branch.


## 🧑‍💻 solution

```groovy
pipeline {
    agent { label 'stapp01' }
    parameters {
        string(name: 'BRANCH', defaultValue: 'master', description: 'Branch to deploy')
    }
    stages {
        stage('Deploy') {
            when {
                anyOf {
                    expression { params.BRANCH == 'master' }
                    expression { params.BRANCH == 'feature' }
                }
            }
            steps {
                sh 'cd /var/www/html && git pull origin ${params.BRANCH}'
                sh 'sudo systemctl restart httpd'
            }
        }
    }
}
```


