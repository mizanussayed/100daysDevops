# Day 97: Create IAM Policy Using Terraform

## 🎯 task
Create an IAM policy named iampolicy_ammar in us-east-1 region using Terraform. 
It must allow read-only access to the EC2 console, i.e., 
this policy must allow users to view all instances, AMIs, and snapshots in the Amazon EC2 console.

## 🧑‍💻 solution

### main.tf
```hcl
resource "aws_iam_policy" "iampolicy_ammar" {
  name        = "iampolicy_ammar"
  description = "Read-only access to EC2 instances, AMIs, and snapshots for console viewing"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeImages",
          "ec2:DescribeSnapshots",
          "ec2:DescribeVolumes",
          "ec2:DescribeTags",
          "ec2:DescribeInstanceStatus",
          "ec2:DescribeAvailabilityZones",
          "ec2:DescribeRegions",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeKeyPairs",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DescribeSubnets",
          "ec2:DescribeVpcs"
        ]
        Resource = "*"
      }
    ]
  })
}
```