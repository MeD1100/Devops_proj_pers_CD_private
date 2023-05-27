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

resource "aws_iam_role" "nodes_general" {
  name = "eks-node-group-general"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }, 
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}


resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy_general" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role = aws_iam_role.nodes_general.name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy_general" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role = aws_iam_role.nodes_general.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role = aws_iam_role.nodes_general.name
}

# Resource: aws_eks_node_group
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group

resource "aws_eks_node_group" "nodes_general" {
  cluster_name = aws_eks_cluster.eks.name
  version = "1.26"
  node_group_name = "nodes-general"
  node_role_arn = aws_iam_role.nodes_general.arn

  subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]

  scaling_config {
    desired_size = 2
    max_size = 5
    min_size = 0
  }

  update_config {
    max_unavailable = 1
  }

  ami_type = "AL2_x86_64"

  capacity_type = "ON_DEMAND"

  disk_size = 20

  force_update_version = false

  instance_types = ["t2.micro"]

  # remote_access {
  #   ec2_ssh_key               = aws_key_pair.TF_key.key_name
  #   source_security_group_ids = [aws_security_group.ng-sg.id]
  # }

  labels = {
    role = "nodes-general"
  }

  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy_general,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy_general,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
  ]

  # Allow external changes without Terraform plan difference
  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }
}

//Updating Kubectl Config File
resource "null_resource" "update-kube-config" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name eks --region eu-west-3 --profile PFE_Account_2"
  }
  depends_on = [
    aws_eks_node_group.nodes_general
  ] 
}