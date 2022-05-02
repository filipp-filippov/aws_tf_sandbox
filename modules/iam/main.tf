data "aws_caller_identity" "current" {}

data "aws_organizations_organization" "current" {}

data "template_file" "tf_permissions" {
  template = file("${path.module}/terraform_role.json")
}

data "template_file" "tf_assume_role" {
  template = file("${path.module}/assume_role.tpl")
  vars  = {
    account_id  = data.aws_caller_identity.current.account_id
  }
}

resource "aws_organizations_organizational_unit" "mgmt" {
  name      = "mgmt_ou"
  parent_id = data.aws_organizations_organization.current.roots[0].id
}

resource "aws_iam_policy" "mgmt-tf" {
  name = var.tf_policy_name
  policy = data.template_file.tf_permissions.rendered
}

resource "aws_iam_role" "mgmt-tf-role" {
  name = "TerraformMGMTRole"
  assume_role_policy = data.template_file.tf_assume_role.rendered
  tags = {
    env = var.iam_role_env
  }
}

resource "aws_iam_role_policy_attachment" "attach-tf-policies" {
  policy_arn = aws_iam_policy.mgmt-tf.arn
  role       = aws_iam_role.mgmt-tf-role.arn
}

resource "aws_iam_role_policy_attachment" "attach-tf-policy" {
  role       = aws_iam_role.mgmt-tf-role.arn
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

