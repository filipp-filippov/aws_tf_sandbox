data "aws_caller_identity" "current" {}

data "aws_iam_session_context" "current" {
  arn = data.aws_caller_identity.current.arn
}

#output "users_summary" {
#  value = [
#    module.john_doe.summary
#  ]
#}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}

output "session_arn" {
  value = data.aws_iam_session_context.current.arn
}

output "vpc_compute_network_cidr" {
  value = module.vpc.db_compute_network_cidr
}

output "vpc_compute_network_id" {
  value = module.vpc.mgmt_compute_network_id
}

output "vpc_db_network_id" {
  value = module.vpc.mgmt_db_network_id
}

output "vpc_session_arn" {
  value = module.vpc.session_arn
}

/*output "links" {
  value = {
    aws_console_sign_in    = "https://${aws_organizations_account.users.id}.signin.aws.amazon.com/console/"
    switch_role_staging    = "https://signin.aws.amazon.com/switchrole?account=${aws_organizations_account.staging.id}&roleName=${urlencode(module.developer_role_staging.role_name)}&displayName=${urlencode("Developer@staging")}"
    switch_role_production = "https://signin.aws.amazon.com/switchrole?account=${aws_organizations_account.production.id}&roleName=${urlencode(module.developer_role_staging.role_name)}&displayName=${urlencode("Developer@production")}"
  }
}*/
