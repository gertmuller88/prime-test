resource "aws_iam_role" "prime-test-cluster" {
  name               = "prime-test-cluster"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
          "Service": "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "prime-test-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.prime-test-cluster.name
}

resource "aws_iam_role_policy_attachment" "prime-test-cluster-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.prime-test-cluster.name
}

resource "aws_security_group" "prime-test-cluster" {
  name        = "prime-test-cluster"
  description = "Cluster communication with worker nodes"
  vpc_id      = aws_vpc.prime-test.id

  egress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "prime-test"
  }
}

resource "aws_security_group_rule" "prime-test-cluster-ingress-workstation-https" {
  cidr_blocks       = [local.workstation-external-cidr]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.prime-test-cluster.id
  to_port           = 443
  type              = "ingress"
}

resource "aws_eks_cluster" "prime-test" {
  name     = var.cluster-name
  role_arn = aws_iam_role.prime-test-cluster.arn

  vpc_config {
    security_group_ids = [aws_security_group.prime-test-cluster.id]
    subnet_ids         = aws_subnet.prime-test[*].id
  }

  depends_on = [
    aws_iam_role_policy_attachment.prime-test-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.prime-test-cluster-AmazonEKSVPCResourceController,
  ]
}
