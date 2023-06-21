#AWS Fargate, now, doesn't support Persistent Volumes back by EBS. So we need to use EFS.
#With that, we could use ReadWriteMany mode and mount volume to multiple pods.
#For information, with EBS, we can mount volume only to a single pod.
#Let's create EFS file system with Terraform.

resource "aws_efs_file_system" "eks" {
  creation_token = "eks"

  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = true

  # lifecycle_policy {
  #   transition_to_ia = "AFTER_30_DAYS"
  # }

  tags = {
    Name = "eks"
  }
}

#Now, AWS Fargate doesn't support dynamic provisioning, regular EKS with EC2 does.
#For Fargate, we need to create network endpoints, preferably for each availability 
#Moreover, we need to make sure to include SGs to the EKS cluster otherwise we won't be able to allocate the volume.
resource "aws_efs_mount_target" "zone-a" {
  file_system_id  = aws_efs_file_system.eks.id
  subnet_id       = aws_subnet.private_1.id
  security_groups = [aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id]
}

resource "aws_efs_mount_target" "zone-b" {
  file_system_id  = aws_efs_file_system.eks.id
  subnet_id       = aws_subnet.private_2.id
  security_groups = [aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id]
}
