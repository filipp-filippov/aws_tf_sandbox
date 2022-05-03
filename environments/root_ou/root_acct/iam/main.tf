terraform {
  backend "s3" {
      bucket         = "root-tfstate-1"
      key            = "tfstate-root/iam"
      region         = "eu-central-1"
      dynamodb_table = "root-terraform-lock"
      encrypt        = true
    }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

data aws_organizations_organization "current" {}

provider "aws" {
  region = "eu-central-1"
  shared_credentials_files = ["/root/.aws/credentials"]
  profile = "default"
}

#Put Environments backends here

module "tf-iam-mgmt" {
  source = "../../../../modules/iam_terraform_role"
  iam_role_env = "mgmt"
  org_account_id  = data.aws_organizations_organization.current.accounts['mgmt'].id
}

module "tf-iam-dev" {
  source = "../../../../modules/iam_terraform_role"
  iam_role_env = "dev"
  org_account_id = data.aws_organizations_organization.current.accounts['development'].id
}