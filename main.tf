provider "aws" {
  region = "eu-central-1"
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

resource "aws_organizations_organization" "tft-test" {
}

resource "aws_organizations_organizational_unit" "dev-ou" {
  name      = "dev"
  parent_id = aws_organizations_organization.tft-test.roots[0].id

  accounts  {
    name  = aws_organizations_account.development.name
    id    = aws_organizations_account.development.id
  }
}

resource "aws_organizations_organizational_unit" "prod-ou" {
  name      = "prod"
  parent_id = aws_organizations_organization.tft-test.roots[0].id

  accounts  {
    name = aws_organizations_account.production.name
    id    = aws_organizations_account.development.id
  }
}

resource "aws_organizations_account" "development" {
  name      = local.account_name["development"]
  email     = local.account_owner_email["development"]
  role_name = "Admin"
}

resource "aws_organizations_account" "production" {
  name      = local.account_name["production"]
  email     = local.account_owner_email["production"]
  role_name = "Admin"
}

