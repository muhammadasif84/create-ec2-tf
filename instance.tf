

resource "aws_instance" "aws-ec2" {

  ami           = "ami-0866a3c8686eaeeba"
  instance_type = "t2.micro"
  tags = {
    Name = "aws-ec2-tf"
  }

}