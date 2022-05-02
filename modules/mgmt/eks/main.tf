data "terraform_remote_state" "remote-mgmt" {
  backend = "s3"
  config  = {
    bucket  = "mgmt-tfstate"
    key = "ou/mgmt"
    region  = "eu-central-1"
  }
}

data "terraform_remote_state" "remote-root" {
  backend = "s3"
  config  = {
    bucket  = "root-tfstate-1"
    key = "tfstate-root"
    region  = "eu-central-1"
  }
}

resource "aws_eks_cluster" "dev-eks" {
  name     = "dev-eks"
  role_arn = data.terraform_remote_state.remote-root.outputs.terraform_role_arn

  vpc_config {
    subnet_ids = [data.terraform_remote_state.remote-mgmt.outputs.vpc_compute_network_id]
  }
}

output "endpoint" {
  value = aws_eks_cluster.dev-eks.endpoint
}


output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.dev-eks.certificate_authority[0].data
}

