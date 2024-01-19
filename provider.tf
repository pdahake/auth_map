# terraform {
#   backend "s3" {
#     bucket         = "pritam-tf-state-backend"
#     key            = "terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "terraform_state"
#   }
# }
locals {
  dir = replace(basename(path.cwd), "_", "-")
}
terraform {
  backend "s3" {
    bucket         = "pritam-tf-state-backend"
    key            = "auth-map/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform_state"
    encrypt        = true
    profile        = "terraform"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.32.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.20"
    }
  }
}

provider "aws" {
  shared_credentials_files = ["~/.aws/credentials"]
  shared_config_files      = ["~/.aws/config"]
  profile                  = "terraform"

  region = "us-east-1"
  # assume_role {
  #   role_arn = "arn:aws:iam::635066407893:role/tf-master"
  # }
  default_tags {
    tags = {
      Environment = "Test"
      Name        = "EKS"
    }
  }
}

# provider "kubernetes" {
#   host                   = data.aws_eks_cluster.eks.endpoint
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority.0.data)
#   token                  = data.aws_eks_cluster_auth.eks.token
# }

# provider "kubernetes" {
#   host                   = module.eks.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     command     = "aws"
#     # This requires the awscli to be installed locally where Terraform is executed
#     args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
#   }
# }