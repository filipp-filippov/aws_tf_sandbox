data "aws_caller_identity" "current" {}

data "aws_organizations_organization" "current" {}

data "template_file" "tf_permissions" {
  template = file("${path.module}/terraform_role.json")
}

data "template_file" "tf_assume_role" {
  ignore_changes = [
    name,
    policy
  ]
  template = file("${path.module}/assume_role.tpl")
  #FIXME That should be manual input
  vars  = {
    mgmt_account_id  = var.mgmt_account_id
  }
}

resource "aws_iam_policy" "mgmt-tf" {
  name = var.tf_policy_name
  policy = data.template_file.tf_permissions.rendered
  lifecycle {
    ignore_changes = [
      name,
      policy
    ]
  }
}

resource "aws_iam_role" "mgmt-tf-role" {
  name = "${var.mgmt_tf_role_name}-${var.org_account_id}"
  assume_role_policy = data.template_file.tf_assume_role.rendered
  tags = {
    env = var.iam_role_env
  }
}

resource "aws_iam_role_policy_attachment" "attach-tf-policies" {
  policy_arn = aws_iam_policy.mgmt-tf.arn
  role       = aws_iam_role.mgmt-tf-role.name
}

resource "aws_iam_role_policy_attachment" "attach-eks-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.mgmt-tf-role.name
}

