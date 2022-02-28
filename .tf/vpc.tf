resource "aws_vpc" "prime-test" {
  cidr_block = "10.0.0.0/16"

  tags = tomap({
    "Name"                                      = "prime-test-node",
    "kubernetes.io/cluster/${var.cluster-name}" = "shared",
  })
}

resource "aws_subnet" "prime-test" {
  count                   = 2
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.prime-test.id

  tags = tomap({
    "Name"                                      = "prime-test-node",
    "kubernetes.io/cluster/${var.cluster-name}" = "shared",
  })
}

resource "aws_internet_gateway" "prime-test" {
  vpc_id = aws_vpc.prime-test.id

  tags = {
    Name = "prime-test"
  }
}

resource "aws_route_table" "prime-test" {
  vpc_id = aws_vpc.prime-test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prime-test.id
  }
}

resource "aws_route_table_association" "prime-test" {
  count          = 2
  subnet_id      = aws_subnet.prime-test.*.id[count.index]
  route_table_id = aws_route_table.prime-test.id
}
