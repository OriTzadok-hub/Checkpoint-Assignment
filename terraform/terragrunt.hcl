remote_state {
  backend = "s3"
  config = {
    bucket         = "ori-state-bucket"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
  }
}
