data "aws_organizations_organization" "current" {}

data "aws_caller_identity" "current" {}

#output "users_summary" {
#  value = [
#    module.john_doe.summary
#  ]
#}

output "account_ids" {
  value = data.aws_organizations_organization.current.accounts[*].id
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}
/*output "links" {
  value = {
    aws_console_sign_in    = "https://${aws_organizations_account.users.id}.signin.aws.amazon.com/console/"
    switch_role_staging    = "https://signin.aws.amazon.com/switchrole?account=${aws_organizations_account.staging.id}&roleName=${urlencode(module.developer_role_staging.role_name)}&displayName=${urlencode("Developer@staging")}"
    switch_role_production = "https://signin.aws.amazon.com/switchrole?account=${aws_organizations_account.production.id}&roleName=${urlencode(module.developer_role_staging.role_name)}&displayName=${urlencode("Developer@production")}"
  }
}*/
