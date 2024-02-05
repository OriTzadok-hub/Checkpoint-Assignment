# DevOps Home Assignment

## Overview

This project automates the deployment of a cloud-based service, using AWS for content delivery via CloudFront and data storage in S3, with exclusive S3 access through CloudFront. It incorporates Terraform and Terragrunt for infrastructure management, GitHub Actions for CI/CD, and a Python script for data processing. This setup demonstrates efficient DevOps practices, focusing on automation, scalability, and secure data access.

## Prerequisites

- AWS Account with access credentials.
- Local installations of Python, Terraform, and Terragrunt are required only for manual execution and local testing of the infrastructure and application code.

## Setup Instructions

### Automated Deployment with GitHub Actions

1. **AWS Credentials**: Add `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` as secrets in the GitHub repository (`Settings > Secrets`).

2. **Workflow Dispatch**: Trigger the deployment workflow from the `Actions` tab in the repository.

### Manual Deployment

#### Terraform and Terragrunt

1. Install Terraform and Terragrunt.
2. Install AWS CLI
2. Use `aws configure` to set AWS CLI credentials.
3. Navigate to the Terraform directory, adjust `terragrunt.hcl` for your state store and modify terraform.tfvars to use the s3 name you wish for, then execute:
   - `terragrunt init`
   - `terragrunt plan`
   - `terragrunt apply`

#### Running Python Script Locally

1. Ensure Python is installed.
2. In the `python` folder, run `pip install -r requirements.txt`.
3. Set `BUCKET_NAME` and `CLOUDFRONT_DOMAIN` as environment variables or modify the script.
4. Execute the script with `python assignment-code.py`.

## Conclusion

This guide outlines the deployment process for both automated and manual setups, utilizing GitHub Actions, Terraform, Terragrunt, and Python for a comprehensive DevOps cycle.
