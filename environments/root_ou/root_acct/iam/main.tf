terraform {
  backend "s3" {
      bucket         = "root-tfstate-1"
      key            = "tfstate-root/iam"
      region         = "eu-central-1"
      dynamodb_table = "root-terraform-lock"
      encrypt        = true
    }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

data aws_organizations_organization "current" {}

provider "aws" {
  region = "eu-central-1"
  shared_credentials_files = ["/root/.aws/credentials"]
  profile = "default"
}

#Put Organizational units here

module "mgmt_org_unit" {
  source = "../../../../modules/organization_units"
  ou_name = "mgmt_ou"
}

module "dev_org_unit" {
  source = "../../../../modules/organization_units"
  ou_name = "development_ou"
}

module "infosec_org_unit" {
  source = "../../../../modules/organization_units"
  ou_name = "infosec_ou"
}

#Put Environments backends here
#Big thing it's to use outputs with account IDS while accounts creation

module "tf-iam-policy" {
  source = "../../../../modules/iam_terraform_role/policy"
  iam_role_env = "dev"
}

module "tf-iam-role-mgmt" {
  source = "../../../../modules/iam_terraform_role/role"
  depends_on = [module.tf-iam-policy]
  iam_role_env = "mgmt"
  iam_policy_arn  = module.tf-iam-policy.tf_iam_policy_arn
  org_account_id  = data.aws_organizations_organization.current.accounts[1].id
  mgmt_account_id = data.aws_organizations_organization.current.accounts[1].id
}

module "tf-iam-role-dev" {
  source = "../../../../modules/iam_terraform_role/role"
  depends_on = [module.tf-iam-policy]
  iam_role_env = "dev"
  iam_policy_arn  = module.tf-iam-policy.tf_iam_policy_arn
  org_account_id = data.aws_organizations_organization.current.accounts[0].id
  mgmt_account_id = data.aws_organizations_organization.current.accounts[1].id
}

