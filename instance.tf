#creating basic ec2-instance
resource "aws_instance" "aws-ec2" {

  ami                    = var.image-id
  instance_type          = var.instance-type
  key_name               = aws_key_pair.key-pair-ec2.key_name              #assinging key-pair to an instance
  vpc_security_group_ids = ["${aws_security_group.security-group-ec2.id}"] #assigning security group to an instance
  tags = {
    Name = "aws-ec2-tf"
  }

}