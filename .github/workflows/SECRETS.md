# Quick Reference for GitHub Secrets

## Instructions

1. Go to your GitHub repository
2. Navigate to **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Add each secret below with its value

## Secrets Checklist

### Docker Hub
```
Name: DOCKER_USERNAME
Value: your_docker_hub_username

Name: DOCKER_PASSWORD
Value: your_docker_hub_access_token
```

### AWS (Terraform)
```
Name: AWS_ACCESS_KEY_ID
Value: your_aws_access_key

Name: AWS_SECRET_ACCESS_KEY
Value: your_aws_secret_key
```

### EC2 Deployment
```
Name: EC2_HOST
Value: ec2-instance-ip-or-dns

Name: EC2_USER
Value: ec2-user (or ubuntu)

Name: EC2_PRIVATE_KEY
Value: -----BEGIN RSA PRIVATE KEY-----
       [entire private key content]
       -----END RSA PRIVATE KEY-----

Name: EC2_PORT
Value: 22
```

### Vagrant VM Deployment
```
Name: VAGRANT_HOST
Value: vagrant-vm-ip-or-dns

Name: VAGRANT_USER
Value: vagrant

Name: VAGRANT_PRIVATE_KEY
Value: -----BEGIN RSA PRIVATE KEY-----
       [entire private key content]
       -----END RSA PRIVATE KEY-----

Name: VAGRANT_PORT
Value: 22
```

## Total Secrets Required: 12

- 2 Docker Hub secrets
- 2 AWS secrets
- 4 EC2 secrets
- 4 Vagrant secrets
