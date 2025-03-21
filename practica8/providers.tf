terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.83.0, <5.89.0, !=5.83.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.1"
    }
  }
  required_version = "~>1.10.0"
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = var.tags
  }
}

