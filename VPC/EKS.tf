#data "aws_eks_cluster" "cluster" {
#  name = module.eks.cluster_id
#}
#
#data "aws_eks_cluster_auth" "cluster" {
#  name = module.eks.cluster_id
#}
#
#provider "kubernetes" {
#  host                   = data.aws_eks_cluster.cluster.endpoint
#  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
#  token                  = data.aws_eks_cluster_auth.cluster.token
#  load_config_file       = false
#  version                = ">=1.9"
#}
#
#module "eks" {
#  source          = "terraform-aws-modules/eks/aws"
#  cluster_name    = "privyID-eks"
#  cluster_version = "1.17"
#  subnets         = ["subnet-06bc30e08580a320b","subnet-0b8387328e8b7870e"]
#  vpc_id          = "vpc-08841411d1a63098d"
#
#
#  node_groups = {
#    public = {
#      subnets          = ["subnet-06bc30e08580a320b"]
#      desired_capacity = 1
#      max_capacity     = 2
#      min_capacity     = 1
#
#      instance_type = "t2.small"
#      k8s_labels = {
#        Environment = "public"
#      }
#    }
#    private = {
#      subnets          = ["subnet-0b8387328e8b7870e"]
#      desired_capacity = 1
#      max_capacity     = 2
#      min_capacity     = 1
#
#      instance_type = "t2.small"
#      k8s_labels = {
#        Environment = "private"
#      }
#    }
#  }
#
#}