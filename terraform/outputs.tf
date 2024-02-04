output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket created"
  value       = module.s3.s3_bucket_arn
}

output "cloudfront_distribution_id" {
  description = "The ID of the CloudFront distribution created"
  value       = module.cloudfront.cloudfront_distribution_id
}

output "cloudfront_distribution_domain_name" {
  description = "The domain name of the CloudFront distribution created"
  value       = module.cloudfront.cloudfront_distribution_domain
}
