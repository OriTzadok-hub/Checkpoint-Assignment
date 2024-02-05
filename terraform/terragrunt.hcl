# Terragrunt Configuration File
#
# This file configures Terragrunt to manage the remote state of your Terraform configurations.
# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple
# Terraform modules, including remote state management, locking, and more.

# Remote State Configuration:
# The `remote_state` block is used to configure the backend for Terraform state files.
# Storing state files remotely allows for team collaboration and ensures the state is
# securely saved and versioned. This configuration specifies the use of an S3 bucket
# for storing the Terraform state file.

remote_state {
  # Specifies the backend type; in this case, AWS S3 is used.
  backend = "s3"
  
  # Configuration for the S3 backend.
  config = {
    bucket         = "ori-state-bucket" # The name of the S3 bucket where the state file will be stored.
    key            = "terraform.tfstate" # The path within the bucket to the state file.
    region         = "eu-central-1"      # The AWS region where the S3 bucket is located.
    encrypt        = true                # Enables encryption at rest for the state file stored in S3.
    # Additional configuration options can be specified here, such as `dynamodb_table` for state locking.
  }
}

# Usage:
# Ensure that an S3 bucket named "ori-state-bucket" exists in the specified region ("eu-central-1") and
# is accessible with the AWS credentials configured in your environment. The bucket should be configured
# to encrypt objects by default, although Terragrunt will attempt to encrypt the state file regardless.
# If you're using state locking, also ensure that the DynamoDB table specified (if any) exists and is configured properly.

# Before running `terragrunt apply` or other Terragrunt commands that interact with the remote state,
# it's important to have AWS CLI configured with access to the specified bucket. This ensures that
# Terragrunt can read from and write to the remote state as expected.
