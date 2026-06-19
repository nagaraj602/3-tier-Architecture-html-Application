terraform {
  required_version = ">= 1.16.0"


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.51.0"
    }
  }
}


provider "aws" {
  region = var.aws_region
}

# Provider for WAF in CloudFront requires us-east-1 explicitly, 
# which is already our default, but it's good practice to define it.
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}