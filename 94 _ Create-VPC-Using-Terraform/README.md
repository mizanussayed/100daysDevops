# Day 94: Create VPC Using Terraform

## 🎯 task
Create a VPC named devops-vpc in region us-east-1 with any IPv4 CIDR block through terraform.

The Terraform working directory is /home/bob/terraform. Create the main.tf file (do not create a different .tf file) to accomplish this task.

## 🧑‍💻 solution
```hcl
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create the VPC
resource "aws_vpc" "devops_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "devops-vpc"
  }
}
```