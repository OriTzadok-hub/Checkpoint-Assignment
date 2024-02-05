# Root Module for Infrastructure Deployment
#
# This Terraform configuration sets up an AWS CloudFront distribution pointing to an S3 bucket. 
# The configuration uses Terraform modules to separate the concerns of creating an S3 bucket 
# and setting up CloudFront distribution, making the codebase more modular, reusable, and easier to manage.
#
# Overview:
# The setup includes two main modules - `s3` and `cloudfront`. The `s3` module is responsible for 
# creating an S3 bucket with configurations to work with CloudFront. The `cloudfront` module sets up 
# the CloudFront distribution, pointing to the S3 bucket as its origin. The configuration ensures 
# that the CloudFront distribution is properly connected with the S3 bucket, enabling content to be 
# served via CloudFront.
#
# Backend:
# The Terraform state is stored in an AWS S3 bucket to enable team collaboration and versioning of the state file.

terraform {
  backend "s3" {}
}

# Modules:
# S3 Module:
# Utilizes the `s3` module to create an AWS S3 bucket. Inputs include the bucket name 
# and the IAM ARN for the Origin Access Identity (OAI) to grant CloudFront access to the bucket content.
# The module also outputs the CloudFront domain name for external access.
module "s3" {
  source               = "./modules/s3"
  bucket_name          = var.bucket_name
  oai_iam_arn          = module.cloudfront.cloudfront_oai_iam_arn
  cloudfront_domain_name = module.cloudfront.cloudfront_distribution_domain
}

# CloudFront Module:
# Configures the CloudFront distribution to serve content from the S3 bucket.
# Inputs include the bucket name, the domain name of the S3 bucket, and an origin ID.
# This module is responsible for creating the CloudFront distribution and connecting it with the S3 bucket.
module "cloudfront" {
  source                = "./modules/cloudfront"
  bucket_name           = var.bucket_name
  s3_bucket_domain_name = module.s3.bucket_domain_name
  s3_bucket_origin_id   = "CF-ori-assignment-bucket-origin"
}

# Usage:
# Before applying this configuration, ensure that the required variables (`var.bucket_name`) are defined,
# either through `terraform.tfvars`, environment variables, or passed directly via the command line.
