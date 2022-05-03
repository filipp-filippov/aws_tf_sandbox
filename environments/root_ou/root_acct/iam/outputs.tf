output "org_acct_list" {
  value = data.aws_organizations_organization.current.accounts.ids
}

