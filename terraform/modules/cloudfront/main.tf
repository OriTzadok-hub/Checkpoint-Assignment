resource "aws_cloudfront_origin_access_identity" "this" {
  comment = "Origin Access Identity for S3 bucket ${var.bucket_name}"
}

resource "aws_cloudfront_distribution" "this" {
  origin {
    domain_name = var.s3_bucket_domain_name
    origin_id   = var.s3_bucket_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
    }
  }

  enabled = true

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.s3_bucket_origin_id

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    name        = "${var.bucket_name}-cloudfront"
    owner       = "ori tzadok"
  }
}
