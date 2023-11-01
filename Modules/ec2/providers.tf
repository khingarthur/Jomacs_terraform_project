# Provider configuration for resources
terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "=5.15.0"
    }
  }
}

#Configure the AWS provider
provider "aws" {
  region = var.region
  alias  = "first"
}