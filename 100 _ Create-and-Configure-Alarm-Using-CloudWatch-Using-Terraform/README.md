# Day 100: Create and Configure Alarm Using CloudWatch Using Terraform

## 🎯 task
1. Launch EC2 Instance: Create an EC2 instance named `nautilus-ec2` using any appropriate Ubuntu AMI (you can use AMI ami-0c02fb55956c7d316).

2. Create CloudWatch Alarm: Create a CloudWatch alarm named `nautilus-alarm` with the following specifications:

- Statistic: Average
- Metric: CPU Utilization
- Threshold: >= 90% for 1 consecutive 5-minute period
- Alarm Actions: Send a notification to the `nautilus-sns-topic` SNS topic.

3. Update the main.tf file (do not create a separate .tf file) to create a EC2 Instance and CloudWatch Alarm.

4. Create an `outputs.tf` file to output the following values:

- `KKE_instance_name` for the EC2 instance name.
- `KKE_alarm_name` for the CloudWatch alarm name.

## 🧑‍💻 solution

## previous code of main.tf
```hcl
resource "aws_sns_topic" "sns_topic" {
  name = "nautilus-sns-topic"
}
```

## updated code of main.tf
```hcl
resource "aws_sns_topic" "sns_topic" {
  name = "nautilus-sns-topic"
}

resource "aws_instance" "ec2_instance" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  tags = {
    Name = "nautilus-ec2"
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "nautilus-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 90

  alarm_actions       = [aws_sns_topic.sns_topic.arn]
}
```

## code of outputs.tf
```hcl
output "KKE_instance_name" {
  value = aws_instance.ec2_instance.tags["Name"]
}

output "KKE_alarm_name" {
  value = aws_cloudwatch_metric_alarm.cpu_alarm.alarm_name
}
```

