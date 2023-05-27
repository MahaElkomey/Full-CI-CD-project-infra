# security group NO.7
resource "aws_security_group" "public_sg" {
  name        = "public_sg"
  vpc_id      = module.my_network.vpc_id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

#########################################################

# security group NO.8
resource "aws_security_group" "private_sg" {
  name        = "private_sg"
  vpc_id      = module.my_network.vpc_id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [module.my_network.vpc_cidr]
  }

  ingress {
    from_port        = 3000
    to_port          = 3000
    protocol         = "tcp"
    cidr_blocks      = [module.my_network.vpc_cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" # mraning all trafic
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

##########################################################
# security group for EKS
resource "aws_security_group" "eks_cluster_sg" {
  name        = "eks-test"
  vpc_id      = module.my_network.vpc_id

  ingress {
    from_port 	     = 0
    to_port   	     = 65535
    protocol  	     = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  ingress {
    description      = "ssh access to public"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks_cluster_sg"
  }
}

