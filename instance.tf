
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
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance-type
  key_name                    = aws_key_pair.key-pair-ec2.key_name              #assinging key-pair to an instance
  vpc_security_group_ids      = ["${aws_security_group.security-group-ec2.id}"] #assigning vpc and security group to an instance
  subnet_id                   = aws_subnet.labs-public-subnet.id
  associate_public_ip_address = true
  tags = {
    Name = "aws-ec2-tf"
  }

  # user_data = file("${path.module}/userData.sh")

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
    source      = "./build"     #terraform machine folder 
    destination = "/tmp/build/" #remote ubuntu machine
  }
  provisioner "file" {
    content     = "This is content from provisioner"
    destination = "/tmp/content.md"
  }

  provisioner "remote-exec" {

    inline = [
      "sudo apt-get update ",
      "sudo apt-get install nginx -y",
      "sudo rm -rf /var/www/html/*",
      "sudo cp -r /tmp/build/* /var/www/html/",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]


  }
  # provisioner "remote-exec" {
  #   script = "./test-script.sh"

  # }
}

output "public-ip" {
  value = aws_instance.aws-ec2.public_ip
}
output "image-id" {
  value = aws_instance.aws-ec2.ami
}

