data "tls_certificate" "eks" {
  url = aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

output "aws_iam_openid_connect_provider_id" {
  value       = aws_iam_openid_connect_provider.eks.id
  description = "aws_iam_openid_connect_provider eks id."
  #Setting an output value as sensitive prevents Terraform from showing its value in plan and apply
  sensitive = false
}