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
    role_arn = local.aws_organization_master_account_id.role_arn
  }

  alias  = "management"
  region = "eu-central-1"
  profile = "default"
}

/*
provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::${aws_organizations_account.production.id}:role/Admin"
  }

  alias  = "production"
  region = "eu-central-1"
  profile = "default"
}
*/


resource "aws_organizations_organization" "tft-test" {
  id                    = local.aws_organization_id["test_org"]
  master_account_id     = local.aws_organization_master_account_id["org_master_id"]
  enabled_policy_types  = ["SERVICE_CONTROL_POLICY"]
}

resource "aws_organizations_organizational_unit" "dev_ou" {
  name      = "dev_ou"
  parent_id = aws_organizations_organization.tft-test.roots[0].id
}

resource "aws_organizations_organizational_unit" "prod_ou" {
  name      = "prod_ou"
  parent_id = aws_organizations_organization.tft-test.roots[0].id
}

/*
resource "aws_organizations_account" "development" {
  parent_id = aws_organizations_organizational_unit.dev_ou.id
  name      = local.account_name["development"]
  email     = local.account_owner_email["development"]
  role_name = "Admin"
}

resource "aws_organizations_account" "production" {
  parent_id = aws_organizations_organizational_unit.prod_ou.id
  name      = local.account_name["production"]
  email     = local.account_owner_email["production"]
  role_name = "Admin"
}*/
