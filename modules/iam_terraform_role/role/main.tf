data "template_file" "tf_assume_role" {
  template = file("${path.module}/assume_role.tpl")
  #FIXME That should be manual input
  vars  = {
    mgmt_account_id  = var.mgmt_account_id
  }
}

resource "aws_iam_role" "mgmt-tf-role" {
  name = "${var.mgmt_tf_role_name}-${var.org_account_id}"
  assume_role_policy = data.template_file.tf_assume_role.rendered
  lifecycle {
    ignore_changes = [name]
  }
  tags = {
    env = var.iam_role_env
  }
}