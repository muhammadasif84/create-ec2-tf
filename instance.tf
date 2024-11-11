
#creating ssh-key
resource "aws_key_pair" "key-pair-ec2" {
  key_name   = "key-pair-ec2"
  public_key = var.ssh-access
}

#out-put of ssh-key pair name
output "key-name" {
  value = aws_key_pair.key-pair-ec2.key_name
}

#creating basic ec2-instance
resource "aws_instance" "aws-ec2" {

  ami           = "ami-0866a3c8686eaeeba"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.key-pair-ec2.key_name #assinging key-pair to an instance
  tags = {
    Name = "aws-ec2-tf"
  }

}