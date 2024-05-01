provider "aws" {
  region = "us-east-1"
}
resource "aws_iam_role" "aws_access_workspace" {
  name = "awsrole-${terraform.workspace}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
managed_policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]

}

resource "aws_iam_instance_profile" "ec2-profile-workspace" {
  name = "car-project-profile-${terraform.workspace}"
  role = aws_iam_role.aws_access_workspace.name
}
resource "aws_instance" "tfmyec2" {
  ami = lookup(var.myami, terraform.workspace)
  instance_type = "${terraform.workspace == "dev" ? "t3a.medium" : "t2.micro"}"
  count = "${terraform.workspace == "prod" ? 1 : 1}"
  key_name = "linux_key_5"
  security_groups = ["${terraform.workspace}-server-sg"]
  iam_instance_profile = aws_iam_instance_profile.ec2-profile-workspace.name
  tags = {
    Name = "${terraform.workspace}-server"
  }
}

variable "myami" {
  type = map(string)
  default = {
    default = "ami-0cff7528ff583bf9a"
    dev     = "ami-06640050dc3f556bb"
    prod    = "ami-08d4ac5b634553e16"
    staging = "ami-08d4ac5b634553e16"
    test    = "ami-08d4ac5b634553e16"
  }
  description = "in order of aAmazon Linux 2 ami, Red Hat Enterprise Linux 8 ami and Ubuntu Server 20.04 LTS amis"
}


resource "aws_security_group" "car-sg" {
  name = "${terraform.workspace}-server-sg"
  description = "terraform import security group"
  tags = {
    Name = "${terraform.workspace}-server-sg"
  }

  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    protocol    = -1
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#output "test-server-ip" {
 # value = aws_instance.tfmyec2[0].public_ip
#}

