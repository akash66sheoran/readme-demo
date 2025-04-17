# Terraform AWS EC2 Demo (readme-demo)

A demonstration Terraform project for provisioning AWS EC2 instances with a custom IAM role, instance profile, security groups, and tagging. Supports multiple instances, remote state, and user data templating.

## Table of Contents

- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Configuration](#configuration)
- [Usage](#usage)
- [Terraform Files](#terraform-files)
- [Variables](#variables)
- [Customizing IAM Policies](#customizing-iam-policies)
- [User Data Scripts](#user-data-scripts)
- [Clean Up](#clean-up)

## Project Structure
```
.
├── backend.tf              # (Optional) Remote backend configuration (S3/DynamoDB)
├── terraform.tf            # Required providers configuration
├── variables.tf            # Input variable definitions
├── variables.tfvars        # Example variable values
├── tags.tf                 # Default tagging local values
├── iam.tf                  # IAM role, policies, and instance profile
├── security-groups.tf      # Security group and ingress/egress rules
├── main.tf                 # EC2 instance resource definitions
└── policies/               # (Optional) Custom IAM policy JSON files
└── user_data/              # (Optional) User data template files
```

## Prerequisites

- [Terraform v1.0+](https://www.terraform.io/downloads)
- AWS account with appropriate IAM permissions
- AWS CLI configured with credentials or environment variables
- (Optional) S3 bucket and DynamoDB table for remote state locking

## Configuration

1. Clone the repository:
   ```bash
   git clone https://github.com/akash66sheoran/readme-demo.git
   cd readme-demo
   ```
2. (Optional) Configure remote state by uncommenting and updating `backend.tf`.
3. Update `variables.tfvars` with your environment-specific values.

## Usage

```bash
terraform init
terraform plan -var-file="variables.tfvars"
terraform apply -var-file="variables.tfvars"
```

## Terraform Files

- **terraform.tf**: Specifies required Terraform providers.
- **backend.tf**: (Commented out) S3/DynamoDB backend for remote state.
- **variables.tf**: Declares input variables.
- **variables.tfvars**: Provides example values for variables.
- **tags.tf**: Defines default tags applied to all resources.
- **iam.tf**: Creates an IAM role, attaches managed/custom policies, and an instance profile.
- **security-groups.tf**: Provisions a security group with ingress and egress rules.
- **main.tf**: Launches EC2 instances and attaches the instance profile.

## Variables

| Variable               | Type   | Description                                     |
|------------------------|--------|-------------------------------------------------|
| `environment`          | string | Deployment environment (e.g., `dev`, `prod`).    |
| `maintainedBy`         | string | Team or individual responsible for resources.   |
| `application`          | string | Purpose or usage of the servers.               |
| `vpc_id`               | string | VPC ID where instances will be launched.        |
| `sg_name`              | string | Security group name.                            |
| `sg_inbound_rules`     | map    | Map of ingress rules (source, ports, protocol).  |
| `instances`            | map    | Map of EC2 instance configurations.             |
| `iam_instance_profile` | string | Name of the IAM instance profile.               |
| `ec2_role_name`        | string | IAM role name for EC2 instances.                |
| `managed_policy_arns`  | list   | List of AWS managed policy ARNs to attach.      |

## Customizing IAM Policies

Place additional JSON policy files under the `policies/` directory. Terraform will automatically create IAM role policies from all `.json` files in this folder.

## User Data Scripts

User data templates are stored in the `user_data/` directory. The EC2 instances render `user_data.sh.tftpl` via the `templatefile` function, passing in the `hostname` variable.

## Clean Up

```bash
terraform destroy -var-file="variables.tfvars"
```

