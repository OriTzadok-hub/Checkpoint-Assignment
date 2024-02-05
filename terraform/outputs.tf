output "s3_bucket_name" {
  description = "The name of the S3 bucket created"
  value       = var.bucket_name
}

output "cloudfront_distribution_domain_name" {
  description = "The domain name of the CloudFront distribution created"
  value       = module.cloudfront.cloudfront_distribution_domain
}
