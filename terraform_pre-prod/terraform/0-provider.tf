provider "aws" {
  region = var.region
  # access_key = var.access_key_testing_med
  # secret_key = var.secret_key_testing_med
}

terraform {
   
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  #configure the created S3 bucket to save the remote storage.
  # backend "s3" {
  #   bucket = "s3backendtfstate-unique12"
  #   dynamodb_table = "state.lock"
  #   key = "global/mystatefile/terraform.tfstate"
  #   region = "us-east-1"
  #   encrypt = true
  # }
}
