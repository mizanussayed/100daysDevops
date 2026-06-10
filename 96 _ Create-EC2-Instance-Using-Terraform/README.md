# Day 96: Create EC2 Instance Using Terraform

## 🎯 task
create an EC2 instance using Terraform with the following requirements:
- The EC2 instance must use the value `nautilus-ec2` as its Name tag.
- Use the Amazon Linux `ami-0c101f26f147fa7fd` image.
- The instance type must be `t2.micro`.
- Create a new RSA key named `nautilus-kp`.
- Attach the default security group.
-The Terraform working directory is /home/bob/terraform. Create the main.tf file (do not create a different .tf file) to provision the instance.

## 🧑‍💻 solution
Create a file named `main.tf` and use:

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "tls_private_key" "nautilus_kp" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "nautilus_kp" {
  key_name   = "nautilus-kp"
  public_key = tls_private_key.nautilus_kp.public_key_openssh
}

resource "local_file" "nautilus_kp_pem" {
  filename        = "nautilus-kp.pem"
  content         = tls_private_key.nautilus_kp.private_key_pem
  file_permission = "0600"
}

resource "aws_instance" "nautilus_ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.nautilus_kp.key_name

  tags = {
    Name = "nautilus-ec2"
  }
}
```

Run:

```bash
terraform init
terraform apply
```


