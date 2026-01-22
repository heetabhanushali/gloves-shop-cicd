terraform {
  required_version = ">= 1.0.0"
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

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"
  name    = "gloves-shop-vpc"
  cidr    = "10.0.0.0/16"

  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = { Project = "gloves-shop" }
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "19.0.0"
  cluster_name    = "gloves-shop-cluster"
  cluster_version = "1.28"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.medium"]
      min_size       = 2
      max_size       = 4
      desired_size   = 2
    }
  }
}

resource "aws_ecr_repository" "services" {
  for_each = toset(["web", "cart", "catalogue", "user", "payment", "shipping", "ratings", "dispatch"])
  name     = "gloves-shop-${each.key}"
}