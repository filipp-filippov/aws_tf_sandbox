data "template_file" "tf_permissions" {
  template = file("${path.module}/terraform_role.json")
}

data "aws_caller_identity" "current" {}

data "template_file" "tf_assume_role" {
  template = file("${path.module}/assume_role.tpl")
  vars  = {
    account_id  = data.aws_caller_identity.current.account_id
  }
}

resource "aws_iam_policy" "mgmt-tf" {
  name = var.tf_policy_name
  policy = data.template_file.tf_permissions.rendered
}

resource "aws_iam_role" "mgmt-tf-role" {
  assume_role_policy = data.template_file.tf_assume_role.rendered
  tags = {
    env = var.iam_role_env
  }
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.mgmt-tf-role.name
  policy_arn = aws_iam_policy.mgmt-tf.arn
}