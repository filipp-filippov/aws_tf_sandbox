output "mgmt_compute_network_cidr" {
  value = aws_subnet.mgmt-compute.cidr_block
}

output "db_compute_network_cidr" {
  value = aws_subnet.mgmt-db.cidr_block
}

output "svc_compute_network_cidr" {
  value = aws_subnet.mgmt-svc.cidr_block
}