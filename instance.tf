
#creating ssh-key
resource "aws_key_pair" "key-pair-ec2" {
  key_name   = "key-pair-ec2"
  public_key = var.ssh-access
}

#out-put of ssh-key pair name
output "key-name" {
  value = aws_key_pair.key-pair-ec2.key_name
}

#creating security-group for an instance
resource "aws_security_group" "security-group-ec2" {
  name        = "security-group-ec2"
  description = "allowed ports"

  dynamic "ingress" {
    for_each = [22, 80, 443, 3306, 2701]
    iterator = port
    content {


      description = "Creating security group"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]

  }
}

#security-group id output
output "sg-id" {
  value = aws_security_group.security-group-ec2.id # "sg-047493b8078ad5696"

}

#creating basic ec2-instance
resource "aws_instance" "aws-ec2" {

  ami                    = "ami-0866a3c8686eaeeba"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.key-pair-ec2.key_name              #assinging key-pair to an instance
  vpc_security_group_ids = ["${aws_security_group.security-group-ec2.id}"] #assigning security group to an instance
  tags = {
    Name = "aws-ec2-tf"
  }

}