provider "aws" {
  profile = "PFE_Account_2"
  region  = "us-west-3"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}