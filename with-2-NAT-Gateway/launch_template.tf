resource "aws_launch_template" "app_lt" {
  name_prefix   = "app-launch-template-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  iam_instance_profile {
    name = aws_iam_instance_profile.app_instance_profile.name
  }

  network_interfaces {
    security_groups = [aws_security_group.app_sg.id]
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd jq
              systemctl start httpd
              systemctl enable httpd
              
              # Install X-Ray Daemon
              curl https://s3.us-east-1.amazonaws.com/aws-xray-assets.us-east-1/xray-daemon/aws-xray-daemon-3.x.rpm -o /home/ec2-user/xray.rpm
              yum install -y /home/ec2-user/xray.rpm
              
              # Fetch Database info from Secrets Manager
              REGION="${var.aws_region}"
              SECRET_ARN="${aws_secretsmanager_secret.db_credentials.arn}"
              DB_SECRETS=$(aws secretsmanager get-secret-value --secret-id $SECRET_ARN --region $REGION --query SecretString --output text)
              
              DB_HOST=$(echo $DB_SECRETS | jq -r '.host')
              DB_USER=$(echo $DB_SECRETS | jq -r '.username')
              DB_PASS=$(echo $DB_SECRETS | jq -r '.password')
              
              # Dummy index.html for testing ALB health checks
              echo "<h1>Application is connected to $DB_HOST</h1>" > /var/www/html/index.html
              EOF
  )
}
