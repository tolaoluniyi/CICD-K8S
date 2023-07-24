# provider "kubernetes" {
#     #load_config_file = "false"
#     host = data.aws_eks_cluster.myAppp-eks-cluster.endpoint
#     token = data.aws_eks_cluster_auth.myAppp-eks-cluster.token
#     cluster_ca_certificate = base64decode(data.aws_eks_cluster.myAppp-eks-cluster.certificate_authority.0.data)
# }

# data "aws_eks_cluster" "myAppp-eks-cluster" {
#     name = module.eks.cluster_name
# }


# data "aws_eks_cluster_auth" "myAppp-eks-cluster" {
#      name = module.eks.cluster_name
# }


module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.2"
  

  cluster_name = "myAppp-eks-cluster"  
  cluster_version = "1.24"

  subnet_ids = module.myAppp-vpc.private_subnets
  vpc_id = module.myAppp-vpc.vpc_id

  tags = {
    environment = "development"
    application = "myAppp"
  }

  eks_managed_node_groups = {
    dev = {
      min_size     = 1
      max_size     = 6
      desired_size = 3

      instance_types = ["t2.small"]
      key_name       = "devopskeypair"
    }
  }
}