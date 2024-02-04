variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket that CloudFront will serve from"
}

variable "s3_bucket_domain_name" {
  type        = string
  description = "The domain name of the S3 bucket that CloudFront will use as the origin"
}

variable "s3_bucket_origin_id" {
  type        = string
  description = "A unique identifier for the origin"
}

