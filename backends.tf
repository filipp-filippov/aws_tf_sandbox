module "backend_management" {
  source      = "./modules/backend"
  bucket_name = local.terraform_state_bucket_name.management

  providers = {
    aws = aws.management
  }
}

/*module "backend_production" {
  source      = "./modules/backend"
  bucket_name = local.terraform_state_bucket_name.production

  providers = {
    aws = aws.production
  }
}*/
