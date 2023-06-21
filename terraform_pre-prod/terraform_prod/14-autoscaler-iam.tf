# module "cluster_autoscaler_irsa_role" {
#   source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
#   version = "5.3.1"

#   role_name                        = "cluster-autoscaler"
#   attach_cluster_autoscaler_policy = true
#   cluster_autoscaler_cluster_ids   = [aws_eks_cluster.cluster.id]

#   oidc_providers = {
#     ex = {
#       provider_arn               = module.eks.oidc_provider_arn
#       namespace_service_accounts = ["kube-system:cluster-autoscaler"]
#     }
#   }
# }