# EC2 Terraform Module

This Terraform configuration creates reusable AWS EC2 instances using modules and separates configuration by environment.

## Project Structure

```
terraform/
├── main.tf                 # Root configuration
├── variables.tf            # Variable definitions
├── outputs.tf              # Output definitions
├── modules/
│   └── ec2/               # Reusable EC2 module
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── environments/
    ├── dev.tfvars         # Development environment values
    ├── staging.tfvars     # Staging environment values
    └── prod.tfvars        # Production environment values
```

## Prerequisites

- Terraform >= 1.0
- AWS account with appropriate credentials
- AWS CLI configured (or environment variables set)

## Usage

### Initialize Terraform

```bash
terraform init
```

### Plan Deployment (Development)

```bash
terraform plan -var-file="environments/dev.tfvars"
```

### Plan Deployment (Staging)

```bash
terraform plan -var-file="environments/staging.tfvars"
```

### Plan Deployment (Production)

```bash
terraform plan -var-file="environments/prod.tfvars"
```

### Apply Changes

```bash
# Development
terraform apply -var-file="environments/dev.tfvars"

# Staging
terraform apply -var-file="environments/staging.tfvars"

# Production
terraform apply -var-file="environments/prod.tfvars"
```

### Destroy Resources

```bash
# Development
terraform destroy -var-file="environments/dev.tfvars"

# Staging
terraform destroy -var-file="environments/staging.tfvars"

# Production
terraform destroy -var-file="environments/prod.tfvars"
```

## Environment Differences

| Parameter | Dev | Staging | Prod |
|-----------|-----|---------|------|
| Instance Type | t2.micro | t2.small | t2.medium |
| Public IP | Yes | No | No |
| Volume Size | 20 GB | 50 GB | 100 GB |
| Volume Type | gp2 | gp2 | gp3 |

## Configuration Notes

1. **AMI ID**: Update `ami_id` in environment files with your desired AMI ID
   - Current value: Ubuntu 20.04 LTS (us-east-1)
   - Find AMI IDs: `aws ec2 describe-images --owners 099720109477 --query 'Images[?Name==`ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*`]' --region us-east-1`

2. **Security Groups**: Update `security_group_ids` with your security group IDs

3. **Subnet**: Update `subnet_id` with your VPC subnet ID if needed

4. **Remote State**: Uncomment and configure the S3 backend in `main.tf` for production use:
   ```hcl
   backend "s3" {
     bucket         = "your-terraform-state-bucket"
     key            = "ec2/terraform.tfstate"
     region         = "us-east-1"
     encrypt        = true
     dynamodb_table = "terraform-locks"
   }
   ```

## Module Features

- ✅ Reusable EC2 module
- ✅ Environment-specific configurations
- ✅ Encrypted root volumes
- ✅ Automatic tagging
- ✅ User data support
- ✅ Flexible security group configuration
- ✅ Custom volume sizing

## Outputs

After applying, you'll receive:
- `ec2_instance_id` - The EC2 instance ID
- `ec2_private_ip` - Private IP address
- `ec2_public_ip` - Public IP address (if assigned)
- `ec2_instance_state` - Instance state
- `ec2_instance_arn` - Instance ARN
