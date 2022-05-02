terraform {
  backend "s3" {
    bucket = "mgmt-tfstate"
    key = "ou/mgmt"
    region = "eu-central-1"
    dynamodb_table = "mgmt-terraform-lock"
    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  shared_credentials_files = ["/root/.aws/credentials"]
  region = "eu-central-1"
  profile = "default"
}

provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/TerraformMGMTRole"
  }
  alias  = "mgmt"
  region = "eu-central-1"
  profile = "default"
}

module "vpc" {
  source  = "./vpc"
  providers = {
    aws = aws.mgmt
  }
}

module "eks" {
  source  = "./eks"
  depends_on = [module.vpc]
  providers = {
    aws = aws.mgmt
  }
}
