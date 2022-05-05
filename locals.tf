locals {
  account_name = {
    mgmt = "tft-management"
/*    production  = "tft-production"*/
  }

  aws_root_org_ou_id  = "r-i4m8"

  # Use existing emails, in case of the account recovery. You will have to use different email addresses. Some email
  # providers offer sub-addressing, with a tag after the + (plus) sign, so you can have infinite amount of addresses.
/*  account_owner_email = {
    development = "ffpaws0@gmail.com"
    production  = "ffpaws1@gmail.com"
  }*/

  terraform_state_bucket_name = {
    management = "tft-development-tfstate"
/*    production  = "tft-production-tfstate"*/
  }

  aws_organization_id = {
    test_org  = "o-1n0dpqtd1i"
  }

  aws_organization_master_account_id = {
    org_master_id = "522740926004"
    role_arn = "arn:aws:organizations::522740926004:account/o-1n0dpqtd1i/522740926004"
  }
}