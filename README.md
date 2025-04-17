This repository provides a sample Terraform configuration to demonstrate provisioning AWS resources, including EC2 instances, security groups, IAM roles, and related configurations. You can use this setup as a template for deploying simple EC2-based applications on AWS.

Table of Contents

Prerequisites

Getting Started

Configuration

Backend Configuration

Variables

Example Variables File

Usage

File Structure

License

Author

Prerequisites

Terraform v1.5 or higher

AWS CLI configured with credentials and permissions to create IAM, EC2, and networking resources

Getting Started

Clone the repository:

git clone https://github.com/akash66sheoran/readme-demo.git
cd readme-demo

(Optional) Configure remote state by uncommenting and updating the backend.tf file.

Customize variables.tfvars to suit your environment.

Configuration

Backend Configuration

By default, state is managed locally. To enable an S3 backend with DynamoDB state locking, update and uncomment the settings in backend.tf:

# terraform {
#   backend "s3" {
#     bucket         = "your-terraform-state-bucket"
#     key            = "path/to/terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "your-lock-table"
#     encrypt        = true
#   }
# }

Variables

Key variables are defined in variables.tf:

environment (string): Deployment environment (e.g., dev, prod)

maintainedBy (string): Team or person responsible for maintenance

application (string): Purpose of the EC2 server

sg_inbound_rules (map): Security group ingress rules (source CIDR, ports, protocol)

sg_name (string): Name for the security group

vpc_id (string): VPC ID where resources will be deployed

instances (map): EC2 instance definitions (AMI ID, instance type, key pair, subnet, block devices, tags)

iam_instance_profile (string): Name for the IAM instance profile

ec2_role_name (string): IAM role name for EC2 instances

managed_policy_arns (list): AWS-managed policy ARNs to attach to the EC2 role

Example Variables File

See variables.tfvars for an example:

vpc_id               = "vpc-0e2e6b5c94514a787"
environment          = "dev"
maintainedBy         = "Mavericks"
application          = "Metrics server"
sg_name              = "metrics-server-sg"
iam_instance_profile = "metrics-server-profile"
ec2_role_name        = "metrics-server-role"

sg_inbound_rules = {
  allow_ssh = {
    source      = "0.0.0.0/0"
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
  }
  allow_http = {
    source      = "0.0.0.0/0"
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
  }
}

instances = {
  server1 = {
    ami                  = "ami-00a929b66ed6e0de6"
    instance_type        = "t2.micro"
    key_name             = "linux-key"
    subnet_id            = "subnet-0e63f62a834b0b60b"
    root_block_device    = { volume_size = 10, volume_type = "gp3" }
    tags                 = { project = "TOD" }
  }
}

managed_policy_arns = [
  "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
]

Usage

Initialize Terraform and configure providers:

terraform init

Preview changes:

terraform plan -var-file=variables.tfvars

Apply configuration:

terraform apply -var-file=variables.tfvars

File Structure
