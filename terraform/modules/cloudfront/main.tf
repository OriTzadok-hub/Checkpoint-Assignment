# CloudFront Module
#
# This Terraform module sets up an AWS CloudFront distribution for a specified S3 bucket. It includes the creation
# of an Origin Access Identity (OAI) to restrict direct S3 access, configuring the CloudFront distribution to serve
# content securely and efficiently.

# Origin Access Identity (OAI) Configuration
# Creates an OAI that is used to give CloudFront permission to fetch content from the S3 bucket securely.
resource "aws_cloudfront_origin_access_identity" "this" {
  comment = "Origin Access Identity for S3 bucket ${var.bucket_name}"
}

# CloudFront Distribution Configuration
# Sets up the CloudFront distribution with specified origins, cache behaviors, and other distribution settings.
resource "aws_cloudfront_distribution" "this" {
  # Origin configuration to specify the S3 bucket details.
  origin {
    domain_name = var.s3_bucket_domain_name  # The domain name of the S3 bucket.
    origin_id   = var.s3_bucket_origin_id    # A unique identifier for the origin.

    # S3 origin configuration to link the OAI with this CloudFront distribution.
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
    }
  }

  enabled = true  # Enable the distribution to start serving content.

  # Default cache behavior settings to define how content is served and cached.
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]  # Restrict methods that can be used to access content.
    cached_methods   = ["GET", "HEAD"]  # Methods for which responses can be cached.
    target_origin_id = var.s3_bucket_origin_id  # Links this behavior to the specified origin.

    # Configuration for forwarding request details to the origin.
    forwarded_values {
      query_string = false  # Do not forward query strings to the origin.
      cookies {
        forward = "none"  # Do not forward cookies to the origin.
      }
    }

    viewer_protocol_policy = "redirect-to-https"  # Enforce HTTPS by redirecting HTTP requests.
    min_ttl                = 0  # Minimum amount of time content is cached.
    default_ttl            = 86400  # Default amount of time content is cached (1 day).
    max_ttl                = 31536000  # Maximum amount of time content is cached (1 year).
  }

  # Restrictions for accessing the distribution, e.g., geo-restrictions.
  restrictions {
    geo_restriction {
      restriction_type = "none"  # No geo-restrictions in place.
    }
  }

  # Viewer certificate configuration to use the default CloudFront SSL/TLS certificate.
  viewer_certificate {
    cloudfront_default_certificate = true
  }

  # Tags for resource identification and management.
  tags = {
    name  = "${var.bucket_name}-cloudfront"  # Naming convention for easy identification.
    owner = "ori tzadok"                     # Owner tag for accountability.
  }
}