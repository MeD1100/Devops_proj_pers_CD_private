provider "aws" {
  profile = "PFE_Account_2"
  region  = "eu-west-3"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

variable "cluster_name" {
  default = "demo2"
}

variable "profile_name"{
  default = "PFE_Account_2"
}

variable "cluster_version" {
  default = "1.22"
}