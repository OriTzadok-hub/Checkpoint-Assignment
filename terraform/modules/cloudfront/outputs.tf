output "cloudfront_distribution_domain" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.this.domain_name
}

output "cloudfront_oai_iam_arn" {
  description = "The CloudFront oai iam arn"
  value = aws_cloudfront_origin_access_identity.this.iam_arn
}

