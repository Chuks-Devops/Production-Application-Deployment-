variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
}

variable "ami_id" {
  description = "AMI ID to use for the EC2 instance"
  type        = string
}

variable "associate_public_ip" {
  description = "Associate a public IP address with the instance"
  type        = bool
  default     = false
}

variable "root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
  default     = 20
}

variable "root_volume_type" {
  description = "Type of root volume"
  type        = string
  default     = "gp2"
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
  default     = []
}

variable "subnet_id" {
  description = "Subnet ID for the instance"
  type        = string
  default     = null
}

variable "user_data" {
  description = "User data script"
  type        = string
  default     = ""
}

variable "spot_enabled" {
  description = "Enable Spot Instance for this EC2 instance"
  type        = bool
  default     = false
}

variable "spot_max_price" {
  description = "Maximum Spot price in USD for the instance"
  type        = string
  default     = ""
}

variable "spot_type" {
  description = "Spot request type: one-time or persistent"
  type        = string
  default     = "one-time"
}

variable "spot_interruption_behaviour" {
  description = "Behavior when the Spot instance is interrupted"
  type        = string
  default     = "terminate"
}

variable "additional_tags" {
  description = "Additional tags for resources"
  type        = map(string)
  default     = {}
}
