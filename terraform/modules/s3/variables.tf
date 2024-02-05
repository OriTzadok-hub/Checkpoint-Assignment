variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket to be created"
}

variable "oai_iam_arn" {
  type        = string
  description = "The IAM ARN for the CloudFront Origin Access Identity"
}

variable "cloudfront_domain_name" {
  type = string
  description = "The domain name of the cloudfront"
}