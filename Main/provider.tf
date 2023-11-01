# Declare an s3 backend to store state files
terraform {
  backend "s3" {
    bucket = "my-main-vpc-bucket"
    key    = "State-Files/terraform.tfstate"
    region = "us-east-2"
  }


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "=5.15.0"
    }
  }
}

#Configure the AWS provider
provider "aws" {
  region = "us-east-2"
}

