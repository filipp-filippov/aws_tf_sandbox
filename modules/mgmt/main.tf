terraform {
  backend "s3" {
    bucket = "mgmt-tfstate"
    key = "ou/mgmt"
    region = "eu-central-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::${local.account_id.mgmt}:role/TerrafromMGMTRole"
  }
  alias  = "mgmt"
  region = "eu-central-1"
  profile = "default"
}

module "vpc" {
  source  = "./vpc"
}