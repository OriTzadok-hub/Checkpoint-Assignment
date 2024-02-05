terraform {
  backend "s3" {}
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name
  oai_iam_arn = module.cloudfront.cloudfront_oai_iam_arn
  cloudfront_domain_name = module.cloudfront.cloudfront_distribution_domain
}

module "cloudfront" {
  source               = "./modules/cloudfront"
  bucket_name          = var.bucket_name
  s3_bucket_domain_name = module.s3.bucket_domain_name
  s3_bucket_origin_id  = "CF-ori-assignment-bucket-origin"
}
