resource "aws_iam_role" "prime-test-node" {
  name               = "prime-test-node"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "prime-test-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.prime-test-node.name
}

resource "aws_iam_role_policy_attachment" "prime-test-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.prime-test-node.name
}

resource "aws_iam_role_policy_attachment" "prime-test-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.prime-test-node.name
}

resource "aws_eks_node_group" "prime-test" {
  cluster_name    = aws_eks_cluster.prime-test.name
  node_group_name = "prime-test"
  node_role_arn   = aws_iam_role.prime-test-node.arn
  subnet_ids      = aws_subnet.prime-test[*].id

  scaling_config {
    desired_size = 3
    max_size     = 5
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.prime-test-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.prime-test-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.prime-test-node-AmazonEC2ContainerRegistryReadOnly
  ]
}
