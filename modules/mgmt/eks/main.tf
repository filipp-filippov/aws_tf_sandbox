data "terraform_remote_state" "remote" {
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
  role_arn = data.terraform_remote_state.remote-root.aws_iam_role.mgmt-tf-role.arn

  vpc_config {
    subnet_ids = [data.terraform_remote_state.remote.vpc.aws_subnet.mgmt-compute.id]
  }
}

output "endpoint" {
  value = aws_eks_cluster.dev-eks.endpoint
}


output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.dev-eks.certificate_authority[0].data
}

