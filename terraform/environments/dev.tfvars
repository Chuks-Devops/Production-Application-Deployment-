# Development Environment Variables

aws_region     = "us-east-1"
environment    = "dev"
project_name   = "myproject"
instance_name  = "dev-web-server"
instance_type  = "t2.micro"
ami_id         = "ami-0c55b159cbfafe1f0"  # Ubuntu 20.04 LTS - update for your region
associate_public_ip = true
root_volume_size    = 20
root_volume_type    = "gp2"
security_group_ids  = []
subnet_id           = null

additional_tags = {
  CostCenter = "Engineering"
  Owner      = "DevTeam"
}
