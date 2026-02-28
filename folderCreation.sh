#!/bin/bash

# Array containing all 100 titles
titles=(
"Linux User Setup with Non-Interactive Shell"
"Temporary User Setup with Expiry"
"Secure Root SSH Access"
"Script Execution Permissions"
"SElinux Installation and Configuration"
"Create a Cron Job"
"Linux SSH Authentication"
"Install Ansible"
"MariaDB Troubleshooting"
"Linux Bash Scripts"
"Install and Configure Tomcat Server"
"Linux Network Services"
"IPtables Installation And Configuration"
"Linux Process Troubleshooting"
"Setup SSL for Nginx"
"Install and Configure Nginx as an LBR"
"Install and Configure PostgreSQL"
"Configure LAMP server"
"Install and Configure Web Application"
"Configure Nginx + PHP-FPM Using Unix Sock"
"Set Up Git Repository on Storage Server"
"Clone Git Repository on Storage Server"
"Fork a Git Repository"
"Git Create Branches"
"Git Merge Branches"
"Git Manage Remotes"
"Git Revert Some Changes"
"Git Cherry Pick"
"Manage Git Pull Requests"
"Git hard reset"
"Git Stash"
"Git Rebase"
"Resolve Git Merge Conflicts"
"Git Hook"
"Install Docker Packages and Start Docker Service"
"Deploy Nginx Container on Application Server"
"Copy File to Docker Container"
"Pull Docker Image"
"Create a Docker Image From Container"
"Docker EXEC Operations"
"Write a Docker File"
"Create a Docker Network"
"Docker Ports Mapping"
"Write a Docker Compose File"
"Resolve Dockerfile Issues"
"Deploy an App on Docker Containers"
"Docker Python App"
"Deploy Pods in Kubernetes Cluster"
"Deploy Applications with Kubernetes Deployments"
"Set Resource Limits in Kubernetes Pods"
"Execute Rolling Updates in Kubernetes"
"Revert Deployment to Previous Version in Kubernetes"
"Resolve VolumeMounts Issue in Kubernetes"
"Kubernetes Shared Volumes"
"Kubernetes Sidecar Containers"
"Deploy Nginx Web Server on Kubernetes Cluster"
"Print Environment Variables"
"Deploy Grafana on Kubernetes Cluster"
"Troubleshoot Deployment issues in Kubernetes"
"Persistent Volumes in Kubernetes"
"Init Containers in Kubernetes"
"Manage Secrets in Kubernetes"
"Deploy Iron Gallery App on Kubernetes"
"Fix Python App Deployed on Kubernetes Cluster"
"Deploy Redis Deployment on Kubernetes"
"Deploy MySQL on Kubernetes"
"Deploy Guest Book App on Kubernetes"
"Set Up Jenkins Server"
"Install Jenkins Plugins"
"Configure Jenkins User Access"
"Configure Jenkins Job for Package Installation"
"Jenkins Parameterized Builds"
"Jenkins Scheduled Jobs"
"Jenkins Database Backup Job"
"Jenkins Slave Nodes"
"Jenkins Project Security"
"Jenkins Deploy Pipeline"
"Jenkins Conditional Pipeline"
"Jenkins Deployment Job"
"Jenkins Chained Builds"
"Jenkins Multistage Pipeline"
"Create Ansible Inventory for App Server Testing"
"Troubleshoot and Create Ansible Playbook"
"Copy Data to App Servers using Ansible"
"Create Files on App Servers using Ansible"
"Ansible Ping Module Usage"
"Ansible Install Package"
"Ansible Blockinfile Module"
"Ansible Manage Services"
"Managing ACLs Using Ansible"
"Ansible Lineinfile Module"
"Managing Jinja2 Templates Using Ansible"
"Using Ansible Conditionals"
"Create VPC Using Terraform"
"Create Security Group Using Terraform"
"Create EC2 Instance Using Terraform"
"Create IAM Policy Using Terraform"
"Launch EC2 in Private VPC Subnet Using Terraform"
"Attach IAM Policy for DynamoDB Access Using Terraform"
"Create and Configure Alarm Using CloudWatch Using Terraform"
)

# Loop through titles
for i in "${!titles[@]}"; do
    day=$((i+1))
    title="${titles[$i]}"

    # Create safe folder name
    folder="Day-${day} : $(echo "$title" | tr ' ' '-' | tr -cd '[:alnum:]-')"

    mkdir -p "$folder"

    # Create README.md
    cat <<EOF > "$folder/README.md"
# Day ${day}: ${title}

## Objective
Add your notes and commands here.

## Steps Performed
- 

## Commands Used
\`\`\`bash

\`\`\`

## Outcome
Describe what you achieved.

EOF

done

echo "✅ 100 Day folders with README.md created successfully!"