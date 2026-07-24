# AWS region in which all infrastructure resources are created.
variable "aws_region" {
  description = "AWS region for the Task Manager API infrastructure."
  type        = string
  default     = "us-east-1"
}

# Amazon Machine Image used to launch the EC2 instance.
variable "ami_id" {
  description = "AMI ID for the EC2 instance, valid in the selected AWS region."
  type        = string
}

# EC2 instance size used for the Task Manager API host.
variable "instance_type" {
  description = "EC2 instance type for the Task Manager API host."
  type        = string
  default     = "t3.micro"
}

# Optional existing EC2 key pair for SSH access to the instance.
variable "key_name" {
  description = "Optional name of an existing EC2 key pair for SSH access."
  type        = string
  default     = null
}

# Shared name used to tag the AWS resources created by this configuration.
variable "instance_name" {
  description = "Name tag applied to Task Manager API infrastructure."
  type        = string
  default     = "task-manager-api"
}
