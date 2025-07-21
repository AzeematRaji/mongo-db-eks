module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = ">= 3.0.0, < 5.0.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Name = "mongo-vpc"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.5"

  cluster_name    = var.cluster_name
  cluster_version = "1.33"

  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
  general-purpose = {
    desired_size   = 2
    max_size       = 3
    min_size       = 1
    instance_types = ["t3.small"]
    capacity_type  = "ON_DEMAND"
  }
}

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name = "mongo-eks"
  }
}