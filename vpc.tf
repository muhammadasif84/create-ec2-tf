
resource "aws_internet_gateway" "ig-Route" {
  vpc_id = aws_vpc.labs-vpc.id

  tags = {
    Name = "lab-IG"
  }
}
resource "aws_vpc" "labs-vpc" {
  cidr_block = var.cidr-block

}

resource "aws_subnet" "labs-public-subnet" {
  vpc_id     = aws_vpc.labs-vpc.id
  cidr_block = var.subnet-cidr
}

output "cidr-block" {
  value = aws_vpc.labs-vpc.id
}