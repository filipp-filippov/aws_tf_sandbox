resource "aws_eks_cluster" "dev-eks" {
  name     = "dev-eks"
  role_arn = data.terraform_remote_state.remote.aws_subnet.mgmt-compute.id

  vpc_config {
    subnet_ids = [data.terraform_remote_state.remote.aws_subnet.mgmt-compute.id]
  }
}

output "endpoint" {
  value = aws_eks_cluster.dev-eks.endpoint
}

/*
output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.example.certificate_authority[0].data
}

*/

