output "terraform_role_arn" {
  value = module.tf-iam-mgmt.terraform_role_arn
}

output "org_acct_list" {
  value = module.tf-iam-mgmt.org_accounts_list
}

