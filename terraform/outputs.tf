output "ec2_instance_id" {
  description = "The ID of the EC2 instance"
  value       = module.web_server.instance_id
}

output "ec2_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = module.web_server.instance_private_ip
}

output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.web_server.instance_public_ip
}

output "ec2_instance_state" {
  description = "State of the EC2 instance"
  value       = module.web_server.instance_state
}

output "ec2_instance_arn" {
  description = "ARN of the EC2 instance"
  value       = module.web_server.instance_arn
}
