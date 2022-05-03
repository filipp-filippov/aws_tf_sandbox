data "template_file" "tf_permissions" {
  template = file("${path.module}/terraform_policy.json")
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

resource "aws_iam_role_policy_attachment" "attach-tf-policies" {
  policy_arn = aws_iam_policy.mgmt-tf.arn
  role       = "${var.mgmt_tf_role_name}-${var.org_account_id}"
}

resource "aws_iam_role_policy_attachment" "attach-eks-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${var.mgmt_tf_role_name}-${var.org_account_id}"
}

