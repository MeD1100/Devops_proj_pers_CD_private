provider "aws" {
  region = var.region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

#configure the created S3 bucket to save the remote storage.
  backend "s3" {
    bucket = "s3backendtfstate-prod"
    dynamodb_table = "state-prod.lock"
    key = "global/mystatefile-prod/terraform.tfstate"
    region = "eu-west-3"
    encrypt = true
  }
}
