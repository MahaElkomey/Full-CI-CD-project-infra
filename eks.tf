resource "aws_iam_role" "AmazonEKSNodeRole" {
  name = "AmazonEKSNodeRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}


# attach AmazonEKSWorkerNodePolicy to this role 
resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicyAttachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.AmazonEKSNodeRole.name
}

# attach AmazonEC2ContainerRegistryReadOnly policy to this role 
resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnlyPolicyAttachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.AmazonEKSNodeRole.name
}

# attach AmazonEKS_CNI_Policy to this role 
resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_PolicyAttachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.AmazonEKSNodeRole.name
 } 
####################################################################################

# create eks cluster role 
resource "aws_iam_role" "eksClusterRole" {
  name = "eksClusterRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}


# attach policy to this role 
resource "aws_iam_role_policy_attachment" "eksClusterRolePolicyAttachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eksClusterRole.name
}

####################################################################################
resource "aws_eks_cluster" "eksCluster" {
  name     = "ed-eks-01"
  role_arn = aws_iam_role.eksClusterRole.arn
  version = "1.25"
  enabled_cluster_log_types = ["api","authenticator"]
  vpc_config {
    endpoint_private_access = true
    endpoint_public_access = false
    subnet_ids = [module.my_network.private_subnet_1_id,module.my_network.private_subnet_2_id]
    security_group_ids = [aws_security_group.eks_cluster_sg.id]
  }
  depends_on = [aws_iam_role_policy_attachment.eksClusterRolePolicyAttachment ]
}
#####################################################################################
resource "aws_eks_node_group" "eksClusterNodeGroup" {
  cluster_name    = aws_eks_cluster.eksCluster.name
  node_group_name = "eks-node-group"
  node_role_arn   = aws_iam_role.AmazonEKSNodeRole.arn
  subnet_ids      = [module.my_network.private_subnet_1_id,module.my_network.private_subnet_2_id]
  ami_type = "AL2_x86_64"
  capacity_type = "ON_DEMAND"
  disk_size = "20"
  instance_types = ["t2.small"]
  
  remote_access {
    ec2_ssh_key = "ec2_key"
    source_security_group_ids = [aws_security_group.eks_cluster_sg.id]
  }

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }
  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicyAttachment,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnlyPolicyAttachment,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_PolicyAttachment
  ]
}
