output "bucket_domain_name" {
    description = "The domain name of the s3 bucket"
    value       = aws_s3_bucket.origin.bucket_domain_name
}