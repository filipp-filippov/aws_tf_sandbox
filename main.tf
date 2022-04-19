terraform {
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

provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::${aws_organizations_account.development.id}:role/Admin"
  }

  alias  = "development"
  region = "eu-central-1"
}

provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::${aws_organizations_account.production.id}:role/Admin"
  }

  alias  = "production"
  region = "eu-central-1"
}

