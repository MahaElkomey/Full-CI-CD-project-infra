# RSA key of size 4096 bits
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# ec2 publlic key 
resource "aws_key_pair" "ec2_key" {
  key_name   = "ec2_key"
  public_key = tls_private_key.rsa.public_key_openssh
}

# store our key
resource "local_file" "ec2_key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "ec2_private_key"
}
# create bastion EC2 instance 
resource "aws_instance" "bastion" {
  ami           = var.AMI_ID #Amazon Linux AMI
  instance_type = var.INSTANCE_TYPE
  subnet_id = module.my_network.public_subnet_1_id
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  key_name = "ec2_key"

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > inventory"
  }
}

# create application EC2 instance 
resource "aws_instance" "application" {
  ami           = var.AMI_ID #Amazon Linux AMI
  instance_type = var.INSTANCE_TYPE
  subnet_id = module.my_network.private_subnet_1_id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  key_name = "ec2_key"
}

