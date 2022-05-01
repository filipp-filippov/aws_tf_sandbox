module "backend_staging" {
  source      = "./modules/backend"
  bucket_name = local.terraform_state_bucket_name.development

  providers = {
    aws = aws.development
  }
}

module "backend_production" {
  source      = "./modules/backend"
  bucket_name = local.terraform_state_bucket_name.production

  providers = {
    aws = aws.production
  }
}
