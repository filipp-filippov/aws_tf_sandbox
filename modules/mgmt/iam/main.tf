data "template_file" "tf_permissions" {
  template = file("${path.module}/terraform_role.json")
}

resource "aws_iam_policy" "mgmt-tf" {
  name = var.tf_policy_name
  policy = data.template_file.tf_permissions.rendered
}

resource "aws_iam_role" "mgmt-tf-role" {
  assume_role_policy = aws_iam_policy.mgmt-tf
  tags = {
    env = var.iam_role_env
  }
}
