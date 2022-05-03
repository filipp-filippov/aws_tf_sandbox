output "org_accounts_list" {
  value = data.aws_organizations_organization.current.feature_set
}