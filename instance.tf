#creating basic ec2-instance
resource "aws_instance" "aws-ec2" {

  ami                    = var.image-id
  instance_type          = var.instance-type
  key_name               = aws_key_pair.key-pair-ec2.key_name              #assinging key-pair to an instance
  vpc_security_group_ids = ["${aws_security_group.security-group-ec2.id}"] #assigning security group to an instance
  tags = {
    Name = "aws-ec2-tf"
  }

  user_data = file("${path.module}/userData.sh")

  #defining connection for all provisioners
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${path.module}/id_rsa")
    host        = self.public_ip
  }
  provisioner "file" {
    source      = "./README.md"    #terraform machine file 
    destination = "/tmp/README.md" #remote ubuntu machine
  }
  provisioner "file" {
    source      = "./test-folder"
    destination = "/tmp/test-folder"
  }
  provisioner "file" {
    content     = "This is content from provisioner"
    destination = "/tmp/content.md"
  }

}

output "public-ip" {
  value = aws_instance.aws-ec2.public_ip
}