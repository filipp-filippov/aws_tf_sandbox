#output "users_summary" {
#  value = [
#    module.john_doe.summary
#  ]
#}

/*output "links" {
  value = {
    aws_console_sign_in    = "https://${aws_organizations_account.users.id}.signin.aws.amazon.com/console/"
    switch_role_staging    = "https://signin.aws.amazon.com/switchrole?account=${aws_organizations_account.staging.id}&roleName=${urlencode(module.developer_role_staging.role_name)}&displayName=${urlencode("Developer@staging")}"
    switch_role_production = "https://signin.aws.amazon.com/switchrole?account=${aws_organizations_account.production.id}&roleName=${urlencode(module.developer_role_staging.role_name)}&displayName=${urlencode("Developer@production")}"
  }
}*/

output "terraform_role_arn" {
  value = module.tf-iam.terraform_role_arn
}

output "org_acct_list" {
  value = module.tf-iam.org_accounts_list
}

