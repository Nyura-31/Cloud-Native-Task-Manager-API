# Looks up the account's default VPC so the initial deployment requires no custom network setup.
data "aws_vpc" "default" {
  default = true
}

# Controls inbound and outbound network traffic for the Task Manager API instance.
resource "aws_security_group" "task_manager" {
  name_prefix = "${var.instance_name}-"
  description = "Allow SSH and web traffic to the Task Manager API host"
  vpc_id      = data.aws_vpc.default.id

  # Permits administrative SSH access.
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Permits HTTP traffic for the Nginx reverse proxy.
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Permits HTTPS traffic for TLS termination.
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allows the instance to reach package repositories and other external services.
  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.instance_name}-security-group"
  }
}

# Creates the EC2 host that will run the containerized Task Manager API.
resource "aws_instance" "task_manager" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.task_manager.id]

  tags = {
    Name = var.instance_name
  }
}

# Allocates a stable public IPv4 address and associates it with the API instance.
resource "aws_eip" "task_manager" {
  domain   = "vpc"
  instance = aws_instance.task_manager.id

  tags = {
    Name = "${var.instance_name}-eip"
  }
}
