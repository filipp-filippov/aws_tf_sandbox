data "aws_caller_identity" "current" {}

data "aws_iam_session_context" "current" {
  arn = data.aws_caller_identity.current.arn
}

output "mgmt_compute_network_cidr" {
  value = aws_subnet.mgmt-compute.cidr_block
}

output "mgmt_compute_network_id" {
  value = aws_subnet.mgmt-compute.id
}

output "db_compute_network_cidr" {
  value = aws_subnet.mgmt-db.cidr_block
}

output "mgmt_db_network_id" {
  value = aws_subnet.mgmt-db.id
}

output "svc_compute_network_cidr" {
  value = aws_subnet.mgmt-svc.cidr_block
}

output "session_arn" {
  value = data.aws_iam_session_context.current.arn
}