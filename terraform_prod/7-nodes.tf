# #Variable Declaration
# variable "key_pair_name" {
#   type    = string
#   default = "Kube_key"
# }

# #Resource to Create Key Pair
# resource "aws_key_pair" "TF_key" {
#   key_name   = var.key_pair_name
#   public_key = tls_private_key.rsa.public_key_openssh
# }

# # RSA key of size 4096 bits
# resource "tls_private_key" "rsa" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "local_file" "kube-key" {
#   content  = tls_private_key.rsa.private_key_pem
#   filename = "kubekey"
# }

#Below, EKS code

resource "aws_iam_role" "nodes" {
  name = "eks-node-group-nodes"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}


resource "aws_iam_role_policy_attachment" "amazon-eks-worker-node-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "amazon-eks-cni-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "amazon-ec2-container-registry-read-only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes.name
}
# Resource: aws_eks_node_group
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group

resource "aws_eks_node_group" "private-nodes" {
  cluster_name    = aws_eks_cluster.cluster.name
  version         = var.cluster_version
  node_group_name = "private-nodes"
  node_role_arn   = aws_iam_role.nodes.arn

  subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]

  capacity_type  = "ON_DEMAND"
  disk_size      = 20
  instance_types = ["t2.large"]

  scaling_config {
    desired_size = 2
    max_size     = 6
    min_size     = 2
  }

  # remote_access {
  #   ec2_ssh_key               = aws_key_pair.TF_key.key_name
  #   source_security_group_ids = [aws_security_group.ng-sg.id]
  # }

  labels = {
    role = "general"
  }

  depends_on = [
    aws_iam_role_policy_attachment.amazon-eks-worker-node-policy,
    aws_iam_role_policy_attachment.amazon-eks-cni-policy,
    aws_iam_role_policy_attachment.amazon-ec2-container-registry-read-only,
  ]

  # Allow external changes without Terraform plan difference
  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }
}

output "aws_eks_node_group_private_nodes_id" {
  value       = aws_eks_node_group.private-nodes.id
  description = "aws_eks_node_group_private_nodes id."
  #Setting an output value as sensitive prevents Terraform from showing its value in plan and apply
  sensitive = false
}

//Updating Kubectl Config File
# resource "null_resource" "update-kube-config" {
#   provisioner "local-exec" {
#     command = "aws eks update-kubeconfig --name demo2 --region eu-west-3 --profile PFE_Account_2"
#   }
#   depends_on = [
#     aws_eks_node_group.privates-nodes
#   ] 
# }