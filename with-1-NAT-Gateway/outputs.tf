output "load_balancer_dns_url" {
  description = "The DNS URL of the Application Load Balancer"
  value       = "http://${aws_lb.app_alb.dns_name}"
}

output "cloudfront_domain_url" {
  description = "The Domain URL of the CloudFront Distribution"
  value       = "https://${aws_cloudfront_distribution.cdn.domain_name}"
}