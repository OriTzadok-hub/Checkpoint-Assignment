resource "aws_s3_bucket" "origin" {
  bucket = var.bucket_name
  
  tags = {
    name        = "${var.bucket_name}-origin"
    owner       = "ori tzadok"
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.origin.id
  policy = data.aws_iam_policy_document.s3_policy_document.json
}

data "aws_iam_policy_document" "s3_policy_document" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.origin.arn}/*"]
    principals {
      type        = "AWS"
      identifiers = [var.oai_iam_arn]
    }
  }
}

resource "aws_s3_bucket_cors_configuration" "site_origin" {
  bucket = aws_s3_bucket.origin.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["DELETE", "POST", "GET", "PUT"]
    allowed_origins = ["https://${var.cloudfront_domain_name}"]
  }
}