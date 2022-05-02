output "terraform_role_arn" {
  value = aws_iam_role.mgmt-tf-role.arn
}

output "org_accounts_list" {
  value = data.aws_organizations_organization.current.accounts
}