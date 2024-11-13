#creating security-group for an instance
resource "aws_security_group" "security-group-ec2" {
  name        = "security-group-ec2"
  description = "allowed ports"

  dynamic "ingress" {
    for_each = var.ports
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