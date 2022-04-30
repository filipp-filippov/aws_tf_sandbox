variable "tf_policy_name" {
  type    = string
  default = "Terraform"
}

variable "iam_role_env" {
  type    = string
}

variable "assume_role_acct_id" {
  type    = string
  default = data.aws_caller_identity.current.account_id
}
