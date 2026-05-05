terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Uncomment and configure S3 backend for remote state management
  # backend "s3" {
  #   bucket         = "your-terraform-state-bucket"
  #   key            = "ec2/terraform.tfstate"
  #   region         = "us-east-1"
  #   encrypt        = true
  #   dynamodb_table = "terraform-locks"
  # }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "Terraform"
    }
  }
}

module "web_server" {
  source = "./modules/ec2"

  instance_name       = var.instance_name
  instance_type       = var.instance_type
  ami                 = var.ami_id
  environment         = var.environment
  associate_public_ip = var.associate_public_ip
  root_volume_size    = var.root_volume_size
  root_volume_type    = var.root_volume_type
  security_groups     = var.security_group_ids
  subnet_id           = var.subnet_id
  user_data           = var.user_data
  spot_enabled        = var.spot_enabled
  spot_max_price      = var.spot_max_price
  spot_type           = var.spot_type
  spot_interruption_behaviour = var.spot_interruption_behaviour

  tags = var.additional_tags
}
