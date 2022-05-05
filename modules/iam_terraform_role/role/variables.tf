variable "tf_policy_name" {
  type    = string
  default = "Terraform"
}

variable "iam_role_env" {
  type    = string
}

variable "org_account_id" {
  type = string
}

variable "mgmt_account_id" {
  type = string
}

variable "mgmt_tf_role_name" {
  type  = string
  default = "TerraformMGMTRole"
}

variable "iam_policy_arn" {
  type  = string
}