data "template_file" "tf_permissions" {
  template = file("${path.module}/terraform_policy.json")
}

resource "aws_iam_policy" "mgmt-tf" {
  name = var.tf_policy_name
  policy = data.template_file.tf_permissions.rendered
}