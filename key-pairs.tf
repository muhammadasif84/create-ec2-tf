#creating ssh-key
resource "aws_key_pair" "key-pair-ec2" {
  key_name   = "key-pair-ec2"
  public_key = var.ssh-access

  tags = {
    name = "labs-key-pair"
  }
}

#out-put of ssh-key pair name
output "key-name" {
  value = aws_key_pair.key-pair-ec2.key_name
}