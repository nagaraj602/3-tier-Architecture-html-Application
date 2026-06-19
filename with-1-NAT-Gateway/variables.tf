variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "ami_id" {
  description = "AMI ID for the Launch Template (Amazon Linux)"
  type        = string
  default     = "ami-0521cb2d60cfbb1a6"
}

variable "instance_type" {
  description = "Instance type for the application servers"
  type        = string
  default     = "t3.small"
}

variable "db_instance_type" {
  description = "RDS Instance Type"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "appdatabase"
}

variable "db_username" {
  description = "Database master username"
  type        = string
  default     = "dbadmin"
}

variable "db_password" {
  description = "Database master password"
  type        = string
  sensitive   = true
  default     = "SuperSecretPassword123!"
}

variable "sns_alert_email" {
  description = "Email for CloudWatch SNS alerts"
  type        = string
  default     = "nagarajkamath602@outlook.com"
}