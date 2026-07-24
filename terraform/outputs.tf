# EC2 instance identifier for operational tasks such as SSH and monitoring.
output "instance_id" {
  description = "ID of the Task Manager API EC2 instance."
  value       = aws_instance.task_manager.id
}

# Stable public IPv4 address assigned to the API host.
output "public_ip" {
  description = "Elastic IP address assigned to the Task Manager API instance."
  value       = aws_eip.task_manager.public_ip
}

# Public DNS name associated with the Elastic IP, when AWS provides one.
output "public_dns" {
  description = "Public DNS name associated with the Elastic IP."
  value       = aws_eip.task_manager.public_dns
}
