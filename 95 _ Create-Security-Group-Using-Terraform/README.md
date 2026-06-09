# Day 95: Create Security Group Using Terraform

## 🎯 task
create a security group under the default VPC with the following requirements:

1) The name of the security group must be devops-sg.

2) The description must be Security group for Nautilus App Servers.

3) Add an inbound rule of type HTTP, with a port range of 80, and source CIDR range 0.0.0.0/0.

4) Add another inbound rule of type SSH, with a port range of 22, and source CIDR range 0.0.0.0/0.

## 🧑‍💻 solution
```hcl
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create the Security Group
resource "aws_security_group" "devops_sg" {
    name        = "devops-sg"
    description = "Security group for Nautilus App Servers"
    vpc_id      = data.aws_vpc.default.id
    
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

```
```hcl
# Data source to get the default VPC
data "aws_vpc" "default" {
    default = true
}
```
