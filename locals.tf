locals {
  account_name = {
    development = "bpc-development"
    production  = "bpc-production"
  }

  # Use existing emails, in case of the account recovery. You will have to use different email addresses. Some email
  # providers offer sub-addressing, with a tag after the + (plus) sign, so you can have infinite amount of addresses.
  account_owner_email = {
    development = "ffpaws0@gmail.com"
    production  = "ffpaws1@gmail.com"
  }

  terraform_state_bucket_name = {
    development = "bpc-development-tfstate"
    production  = "bpc-production-tfstate"
  }
}