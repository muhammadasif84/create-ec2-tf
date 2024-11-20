
#providing data sources for ami
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["${var.ownername}"]

  filter {
    name   = "name"
    values = ["${var.image-name}"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

#automation of ec2-instance
resource "aws_instance" "aws-ec2" {

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance-type
  key_name               = aws_key_pair.key-pair-ec2.key_name              #assinging key-pair to an instance
  vpc_security_group_ids = ["${aws_security_group.security-group-ec2.id}"] #assigning vpc and security group to an instance
  tags = {
    Name = "aws-ec2-tf"
  }

  user_data = file("${path.module}/userData.sh")

  #defining connection for all provisioners , docs link of provisioner https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec
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
    source      = "./test-folder"    #terraform machine folder 
    destination = "/tmp/test-folder" #remote ubuntu machine
  }
  provisioner "file" {
    content     = "This is content from provisioner"
    destination = "/tmp/content.md"
  }

  provisioner "remote-exec" {
    inline = [
      "ifconfig > /tmp/ifconfig.output",
      "echo 'This is from terraform' > /tmp/test.txt"
    ]

  }
  provisioner "remote-exec" {
    script = "./test-script.sh"

  }
}

output "public-ip" {
  value = aws_instance.aws-ec2.public_ip
}
output "image-id" {
  value = aws_instance.aws-ec2.ami
}

