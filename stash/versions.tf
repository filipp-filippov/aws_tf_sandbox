terraform {
  required_version = ">= 0.18"
}

/*data "terraform_remote_state" "remote" {
  backend = "s3"
  config  = {
    bucket  = "mgmt-tfstate"
    key = "ou/mgmt"
  }
}*/