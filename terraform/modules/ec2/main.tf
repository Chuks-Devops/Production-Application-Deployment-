resource "aws_instance" "ec2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_groups
  associate_public_ip_address = var.associate_public_ip
  user_data              = var.user_data
  spot_price             = var.spot_enabled ? var.spot_max_price : null
  spot_type              = var.spot_enabled ? var.spot_type : null
  instance_interruption_behaviour = var.spot_enabled ? var.spot_interruption_behaviour : null

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    delete_on_termination = true
    encrypted             = true
  }

  tags = merge(
    {
      Name        = var.instance_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
  }
}
