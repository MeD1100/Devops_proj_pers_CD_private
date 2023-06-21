provider "aws" {
  region = "eu-west-3"
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
  default = "eks-new"
}

variable "cluster_version" {
  default = "1.26"
}