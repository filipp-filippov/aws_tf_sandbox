terraform {
  backend "s3" {
    bucket = "mgmt-tfstate"
    key = "ou/mgmt/networking"
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

data aws_caller_identity "this" {}
data aws_organizations_organization "current" {}

provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::${data.aws_caller_identity.this.account_id}:role/TerraformMGMTRole-${data.aws_organizations_organization.current.accounts[1].id}"
  }
  alias  = "mgmt"
  region = "eu-central-1"
  profile = "default"
}

module "vpc" {
  source  = "../../../../modules/vpc"
  providers = {
    aws = aws.mgmt
  }
}
