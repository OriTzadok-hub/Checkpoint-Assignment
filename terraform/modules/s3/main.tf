# S3 Module
#
# This Terraform module creates an S3 bucket to serve as the origin for content. It configures the bucket with
# a policy to restrict access to a specified Origin Access Identity (OAI) and sets up CORS configuration to
# allow web requests from the associated CloudFront distribution.

resource "aws_s3_bucket" "origin" {
  bucket = var.bucket_name  # Bucket name is dynamically set via input variable.
  
  tags = {
    name  = "${var.bucket_name}-origin"  # Tagging for easy identification and management.
    owner = "ori tzadok"                 # Owner tag for accountability.
  }
}

# S3 Bucket Policy
# Configures the bucket policy to limit access to the CloudFront OAI, allowing only the OAI to retrieve objects.
resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.origin.id  # Reference to the created S3 bucket.
  policy = data.aws_iam_policy_document.s3_policy_document.json  # The policy document defined below.
}

# IAM Policy Document
# Defines the IAM policy to restrict getObject actions to the specified OAI.
data "aws_iam_policy_document" "s3_policy_document" {
  statement {
    actions   = ["s3:GetObject"]  # Only allow object retrieval.
    resources = ["${aws_s3_bucket.origin.arn}/*"]  # Apply to all objects in the bucket.
    principals {
      type        = "AWS"
      identifiers = [var.oai_iam_arn]  # The OAI's ARN.
    }
  }
}

# S3 Bucket CORS Configuration
# Sets the CORS rules for the bucket to accept requests from the CloudFront distribution.
resource "aws_s3_bucket_cors_configuration" "site_origin" {
  bucket = aws_s3_bucket.origin.id  # Reference to the created S3 bucket.

  cors_rule {
    allowed_headers = ["*"]  # Allow all headers.
    allowed_methods = ["DELETE", "POST", "GET", "PUT"]  # Supported methods.
    allowed_origins = ["https://${var.cloudfront_domain_name}"]  # Restrict to CloudFront domain.
  }
}