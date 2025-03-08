terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.83.0, <5.89.0, !=5.83.0"
    }
  }
  required_version = "~>1.10.0"
}

provider "aws" {
  region = "us-east-1"
  alias  = "virginia"
}

provider "aws" {
  region = "us-east-2"
  alias  = "ohio"
}
