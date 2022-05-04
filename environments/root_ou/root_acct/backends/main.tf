terraform {
  backend "s3" {
      bucket         = "root-tfstate-1"
      key            = "tfstate-root/backends"
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

provider "aws" {
  region = "eu-central-1"
  shared_credentials_files = ["/root/.aws/credentials"]
  profile = "default"
}

#Put Environments backends here

module "mgmt-backend" {
  source  = "../../../../modules/backends"
  bucket_name = "mgmt-tfstate"
  aws_ou = "mgmt"
  table_name = "mgmt-terraform-lock"
}

module "mgmt-backend" {
  source  = "../../../../modules/backends"
  bucket_name = "dev-tfstate"
  aws_ou = "dev"
  table_name = "mgmt-terraform-lock"
}

