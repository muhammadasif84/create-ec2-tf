removed {
  from = aws_vpc.labs-vpc
  lifecycle {
    destroy = false
  }
}