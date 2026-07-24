terraform {
  # Defines the Terraform CLI and provider versions required by this configuration.
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configures AWS using the selected region. Credentials are resolved from the
# AWS CLI profile, environment variables, or an attached IAM role.
provider "aws" {
  region = var.aws_region
}
