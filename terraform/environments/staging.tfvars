# Staging Environment Variables

aws_region     = "us-east-1"
environment    = "staging"
project_name   = "myproject"
instance_name  = "staging-web-server"
instance_type  = "t2.small"
ami_id         = "ami-0c55b159cbfafe1f0"  # Ubuntu 20.04 LTS - update for your region
associate_public_ip = false
root_volume_size    = 50
root_volume_type    = "gp2"
security_group_ids  = []
subnet_id           = null

additional_tags = {
  CostCenter = "Engineering"
  Owner      = "DevOpsTeam"
}
