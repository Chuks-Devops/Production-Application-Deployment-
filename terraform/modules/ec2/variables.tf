variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "tags" {
  description = "Tags for the EC2 instance"
  type        = map(string)
  default     = {}
}

variable "associate_public_ip" {
  description = "Associate a public IP address with the instance"
  type        = bool
  default     = true
}

variable "root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
  default     = 20
}

variable "root_volume_type" {
  description = "Type of root volume (gp2, gp3, io1, io2)"
  type        = string
  default     = "gp2"
}

variable "security_groups" {
  description = "List of security group IDs"
  type        = list(string)
  default     = []
}

variable "subnet_id" {
  description = "Subnet ID where instance will be launched"
  type        = string
  default     = null
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

variable "user_data" {
  description = "User data script to run on instance launch"
  type        = string
  default     = ""
}
