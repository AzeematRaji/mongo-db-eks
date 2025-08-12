module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"

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
  version = "20.37.2"

  cluster_name    = var.cluster_name
  cluster_version = "1.33"

  enable_cluster_creator_admin_permissions = true
  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    general = {
      desired_size   = 2
      max_size       = 3
      min_size       = 1
      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"
    }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name = "mongo-eks"
  }
}
