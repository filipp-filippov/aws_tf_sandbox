
provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::${aws_organizations_account.development.id}:role/Admin"
  }

  alias  = "development"
  region = "eu-central-1"
  profile = "default"
}

provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::${aws_organizations_account.production.id}:role/Admin"
  }

  alias  = "production"
  region = "eu-central-1"
  profile = "default"
}



resource "aws_organizations_organization" "tft-test" {
}

resource "aws_organizations_organizational_unit" "this_ou" {
  for_each  = toset(var.OUs)
  name      = each.key
  parent_id = aws_organizations_organization.tft-test.roots[0].id
}

resource "aws_organizations_account" "development" {
  parent_id = aws_organizations_organizational_unit.this_ou.id
  name      = local.account_name["development"]
  email     = local.account_owner_email["development"]
  role_name = "Admin"
}

resource "aws_organizations_account" "production" {
  parent_id = aws_organizations_organizational_unit.this_ou.id
  name      = local.account_name["production"]
  email     = local.account_owner_email["production"]
  role_name = "Admin"
}