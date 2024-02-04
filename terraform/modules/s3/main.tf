resource "aws_s3_bucket" "origin" {
  bucket = var.bucket_name
  
  tags = {
    name        = "${var.bucket_name}-origin"
    owner       = "ori tzadok"
  }
}

resource "aws_s3_bucket_acl" "origin_acl" {
  bucket = aws_s3_bucket.origin.id
  acl    = "private"
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
