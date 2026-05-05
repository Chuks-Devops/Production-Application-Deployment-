# GitHub CI/CD Workflow Setup Guide

This workflow automates testing, building, and deployment across multiple environments.

## Required GitHub Secrets

Add these secrets to your GitHub repository settings (`Settings > Secrets and variables > Actions`):

### Docker Hub Credentials
- `DOCKER_USERNAME` - Your Docker Hub username
- `DOCKER_PASSWORD` - Your Docker Hub access token (not password)

### AWS Credentials (for Terraform)
- `AWS_ACCESS_KEY_ID` - AWS access key
- `AWS_SECRET_ACCESS_KEY` - AWS secret key

### EC2 Instance SSH
- `EC2_HOST` - EC2 instance IP or hostname
- `EC2_USER` - SSH username (usually `ec2-user` or `ubuntu`)
- `EC2_PRIVATE_KEY` - Private SSH key content
- `EC2_PORT` - SSH port (default: 22)

### Vagrant VM SSH
- `VAGRANT_HOST` - Vagrant VM IP or hostname
- `VAGRANT_USER` - SSH username (usually `vagrant`)
- `VAGRANT_PRIVATE_KEY` - Private SSH key content
- `VAGRANT_PORT` - SSH port (default: 22)

## Workflow Stages

### 1. **Terraform Validate**
- Checks code formatting
- Initializes Terraform
- Validates configuration
- Plans infrastructure changes

### 2. **Node.js Tests**
- Installs dependencies
- Runs linter
- Executes tests

### 3. **Docker Build & Push**
- Builds Docker image using multi-stage Dockerfile
- Tags with branch/commit/version info
- Pushes to Docker Hub

### 4. **Deploy to EC2**
- SSHes into EC2 instance
- Pulls latest Docker image
- Stops old containers
- Runs docker-compose up -d

### 5. **Deploy to Vagrant VM**
- SSHes into Vagrant VM
- Pulls latest Docker image
- Stops old containers
- Runs docker-compose up -d

### 6. **Docker Compose Validation**
- Runs docker-compose locally
- Tests health check endpoint
- Verifies setup works

## Setup Instructions

### 1. Create SSH Keys

**For EC2:**
```bash
# If you don't have EC2 key
aws ec2 create-key-pair --key-name github-actions --query 'KeyMaterial' --output text > github-actions.pem
chmod 600 github-actions.pem
```

**For Vagrant:**
```bash
# Vagrant typically uses default key at ~/.vagrant.d/insecure_private_key
cat ~/.vagrant.d/insecure_private_key
```

### 2. Add SSH Keys to GitHub Secrets

Copy the entire private key content (including BEGIN/END lines):

```bash
cat github-actions.pem
# Copy output to EC2_PRIVATE_KEY secret

cat ~/.vagrant.d/insecure_private_key
# Copy output to VAGRANT_PRIVATE_KEY secret
```

### 3. Setup EC2 Instance

```bash
# SSH into EC2
ssh -i github-actions.pem ec2-user@<EC2_IP>

# Install Docker and Docker Compose
sudo yum update -y
sudo yum install -y docker git
sudo usermod -aG docker ec2-user
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Create app directory
mkdir -p ~/nodejs-app
cd ~/nodejs-app
```

### 4. Setup Vagrant VM

```bash
# In your Vagrant VM
vagrant up

# SSH into Vagrant
vagrant ssh

# Install Docker
sudo apt-get update && sudo apt-get install -y docker.io docker-compose

# Add vagrant user to docker group
sudo usermod -aG docker vagrant

# Create app directory
mkdir -p ~/nodejs-app
```

### 5. Prepare docker-compose.yml

Copy `docker-compose.yml` to both EC2 and Vagrant instances:

```bash
scp -i github-actions.pem docker-compose.yml ec2-user@<EC2_IP>:~/nodejs-app/
vagrant scp docker-compose.yml :/home/vagrant/nodejs-app/
```

### 6. Set Environment Variables

On both EC2 and Vagrant, create `.env`:

```bash
cat > ~/nodejs-app/.env << EOF
NODE_ENV=production
PORT=3000
DB_HOST=mysql
DB_PORT=3306
DB_NAME=nodejs_app
DB_USER=root
DB_PASSWORD=your_secure_password
JWT_SECRET=your_jwt_secret_key
JWT_EXPIRE=7d
EOF
```

## Workflow Triggers

The workflow runs on:
- Push to `main` or `develop` branches
- Pull requests to `main` or `develop`

Full deployment (Docker build/push/deploy) only runs on:
- Push to `main` branch

## Testing Locally

### Test Terraform
```bash
cd terraform
terraform plan
```

### Test Node
```bash
cd nodejs
npm install
npm test
```

### Test Docker Build
```bash
cd nodejs
docker build -t nodejs-mysql-app:test .
```

### Test Docker Compose
```bash
cd nodejs
docker compose up -d
curl http://localhost:3000/health
docker compose down
```

## Troubleshooting

### SSH Connection Failed
- Verify IP address in secrets
- Check SSH port (default 22)
- Ensure private key is in correct format
- Test manually: `ssh -i key.pem user@host`

### Docker Push Failed
- Verify Docker Hub credentials
- Check token permissions
- Ensure repository exists or is public

### Terraform Plan Failed
- Verify AWS credentials
- Check Terraform syntax: `terraform validate`
- Review AWS IAM permissions

### Tests Failed
- Check Node version compatibility
- Review test logs in GitHub Actions
- Ensure dependencies installed

## Monitoring

View workflow runs:
1. Go to GitHub repository
2. Click **Actions** tab
3. Select workflow run for details
4. View logs for each job

## Next Steps

1. Add branch protection rules
2. Enable auto-deploy only for main branch
3. Add Slack notifications for failures
4. Set up rollback procedures
5. Configure monitoring and alerts
