# Day 99: Attach IAM Policy for DynamoDB Access Using Terraform

## 🎯 task

1. Create a DynamoDB Table: Create a table named datacenter-table with minimal configuration.

2. Create an IAM Role: Create an IAM role named datacenter-role that will be allowed to access the table.

3. Create an IAM Policy: Create a policy named datacenter-readonly-policy that should grant read-only access (GetItem, Scan, Query) to the specific DynamoDB table and attach it to the role.

4. Create the main.tf file (do not create a separate .tf file) to provision the table, role, and policy.

5. Create the variables.tf file with the following variables:

- `KKE_TABLE_NAME`: name of the DynamoDB table
- `KKE_ROLE_NAME`: name of the IAM role
- `KKE_POLICY_NAME`: name of the IAM policy

6. Create the outputs.tf file with the following outputs:

- `kke_dynamodb_table`: name of the DynamoDB table
- `kke_iam_role_name`: name of the IAM role
- `kke_iam_policy_name`: name of the IAM policy

7. Define the actual values for these variables in the terraform.tfvars file.

8. Ensure that the IAM policy allows only read access and restricts it to the specific DynamoDB table created.

## 🧑‍💻 solution

### main.tf
```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_dynamodb_table" "datacenter_table" {
  name           = var.KKE_TABLE_NAME
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_iam_role" "datacenter_role" {
  name = var.KKE_ROLE_NAME

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "datacenter_readonly_policy" {
  name        = var.KKE_POLICY_NAME
  description = "Read-only access to the specific DynamoDB table"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:Scan",
          "dynamodb:Query"
        ]
        Resource = aws_dynamodb_table.datacenter_table.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "datacenter_role_policy_attachment" {
  role       = aws_iam_role.datacenter_role.name
  policy_arn = aws_iam_policy.datacenter_readonly_policy.arn
}
```

### variables.tf
```hcl
variable "KKE_TABLE_NAME" {
  description = "Name of the DynamoDB table"
  type        = string
  default     = "datacenter-table"
}

variable "KKE_ROLE_NAME" {
  description = "Name of the IAM role"
  type        = string
  default     = "datacenter-role"
}

variable "KKE_POLICY_NAME" {
  description = "Name of the IAM policy"
  type        = string
  default     = "datacenter-readonly-policy"
}
```

### outputs.tf
```hcl
output "kke_dynamodb_table" {
  value = aws_dynamodb_table.datacenter_table.name
}

output "kke_iam_role_name" {
  value = aws_iam_role.datacenter_role.name
}

output "kke_iam_policy_name" {
  value = aws_iam_policy.datacenter_readonly_policy.name
}
```

### terraform.tfvars
```hcl
KKE_TABLE_NAME = "datacenter-table"
KKE_ROLE_NAME = "datacenter-role"
KKE_POLICY_NAME = "datacenter-readonly-policy"
```


