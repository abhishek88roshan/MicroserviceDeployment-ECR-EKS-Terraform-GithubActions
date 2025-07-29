terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Reference existing ECR repository
data "aws_ecr_repository" "httpd_app" {
  name = "my-httpd-app"
}

# Reference existing KMS Alias
data "aws_kms_alias" "cluster" {
  name = "alias/eks/prod-cluster"
}

# Reference existing CloudWatch Log Group for EKS control plane
data "aws_cloudwatch_log_group" "eks" {
  name = "/aws/eks/prod-cluster/cluster"
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "19.21.0"

  cluster_name    = var.eks_cluster_name
  cluster_version = "1.29"
  vpc_id          = data.aws_vpc.default.id
  subnet_ids      = data.aws_subnets.default.ids

  # Use the existing KMS key (from the alias)
  create_kms_key            = false
  cluster_encryption_config = {
    provider_key_arn = data.aws_kms_alias.cluster.target_key_arn
    resources        = ["secrets"]
  }

  # Logging config - do not create, just enable log types
  cluster_enabled_log_types   = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  create_cloudwatch_log_group = false

  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    disk_size      = 20
    instance_types = [var.node_instance_type]
  }

  eks_managed_node_groups = {
    default = {
      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }
}
