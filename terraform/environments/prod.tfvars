# Production Environment Variables

aws_region     = "us-east-1"
environment    = "prod"
project_name   = "myproject"
instance_name  = "prod-web-server"
instance_type  = "t2.medium"
ami_id         = "ami-0c55b159cbfafe1f0"  # Ubuntu 20.04 LTS - update for your region
associate_public_ip = false
root_volume_size    = 100
root_volume_type    = "gp3"
security_group_ids  = []
subnet_id           = null
spot_enabled        = true
spot_max_price      = "0.05"
spot_type           = "one-time"
spot_interruption_behaviour = "terminate"

additional_tags = {
  CostCenter = "Operations"
  Owner      = "ProductionTeam"
  Backup     = "daily"
}
