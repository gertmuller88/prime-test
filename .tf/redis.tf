resource "aws_elasticache_subnet_group" "redis" {
  name       = "prime-test-redis-subnet"
  subnet_ids = aws_subnet.prime-test.*.id
}

resource "aws_security_group" "redis" {
  name        = "redis"
  description = "Redis communication with worker nodes"
  vpc_id      = aws_vpc.prime-test.id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "prime-test"
  }
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "prime-test-redis"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  engine_version       = "3.2.10"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.redis.name
  security_group_ids   = [aws_security_group.redis.id]
}
