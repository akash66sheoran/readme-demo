# Terraform AWS EC2 Provisioning Demo

This repository provides a comprehensive example of how to use Terraform to provision EC2 instances in AWS. It demonstrates key infrastructure components such as IAM roles and policies, security groups, instance profiles, user data scripting, and remote state management. The setup supports scalable deployment using input maps, tagging, and reusable templates.

## 🚀 Features

- Launch multiple EC2 instances with different configurations
- Create and attach custom and managed IAM policies
- Set up security groups with dynamic ingress and egress rules
- Inject user data with templated scripts
- Apply consistent tagging across resources
- Use optional remote state backend with S3 and DynamoDB

## 📁 Project Structure

```
.
├── backend.tf              # (Optional) Remote state backend using S3 and DynamoDB
├── terraform.tf            # Required provider configuration
├── variables.tf            # Input variable declarations
├── variables.tfvars        # Example values for variables
├── tags.tf                 # Centralized default tags for all resources
├── iam.tf                  # IAM role, instance profile, and policies
├── security-groups.tf      # Security group with ingress/egress rules
├── main.tf                 # EC2 instances creation logic
├── policies/               # Custom IAM policies in JSON format
└── user_data/              # User data templates for EC2 instances
```

## ✅ Prerequisites

Make sure the following tools are installed and configured:

- [Terraform v1.0+](https://www.terraform.io/downloads.html)
- AWS CLI configured with IAM credentials
- AWS account with necessary permissions to create resources (EC2, IAM, VPC, etc.)
- (Optional) An S3 bucket and DynamoDB table for remote state locking

## ⚙️ Configuration Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/akash66sheoran/readme-demo.git
   cd readme-demo
   ```

2. **Edit variable values**
   Update the `variables.tfvars` file with your environment-specific values including VPC ID, instance details, etc.

3. **(Optional) Configure remote state**
   Uncomment and configure `backend.tf` to enable remote state storage with S3 and DynamoDB.

## 🚦 Usage

1. **Initialize Terraform**
   ```bash
   terraform init
   ```

2. **Review the execution plan**
   ```bash
   terraform plan -var-file="variables.tfvars"
   ```

3. **Apply the configuration**
   ```bash
   terraform apply -var-file="variables.tfvars"
   ```

4. **Destroy the infrastructure (when needed)**
   ```bash
   terraform destroy -var-file="variables.tfvars"
   ```

## 📜 Variables Explained

| Variable               | Type    | Description                                                       |
|------------------------|---------|-------------------------------------------------------------------|
| `environment`          | string  | Name of the environment (e.g., `dev`, `staging`, `prod`)          |
| `maintainedBy`         | string  | Who maintains these resources (e.g., team name or email)          |
| `application`          | string  | Name or purpose of the application/server                         |
| `vpc_id`               | string  | ID of the VPC where resources will be launched                    |
| `sg_name`              | string  | Name of the security group                                        |
| `sg_inbound_rules`     | map     | Map of inbound security group rules (protocol, ports, CIDRs)      |
| `instances`            | map     | Map of instance configurations including AMI, type, subnet, etc.  |
| `iam_instance_profile` | string  | Name of the IAM instance profile to associate with EC2 instances  |
| `ec2_role_name`        | string  | IAM role name that EC2 will assume                                |
| `managed_policy_arns`  | list    | List of ARNs of AWS-managed IAM policies to attach                |

## 🔐 Custom IAM Policies

You can add additional fine-grained IAM policies in the `policies/` directory as JSON files. These will be automatically picked up by Terraform and attached to the IAM role assigned to EC2 instances.

Example custom policy file path:
```
policies/S3ReadOnly.json
```

## 📝 User Data Templates

Templates stored under `user_data/` allow for flexible bootstrapping. These are rendered using the `templatefile()` function in Terraform.

Example template: `user_data.sh.tftpl`

Variables passed into the template include:
- `hostname`: used to uniquely configure each instance

You can include startup tasks like package installation, logging setup, or pulling configs from a central repo.

## 🧹 Clean Up

To remove all resources created by this module:
```bash
terraform destroy -var-file="variables.tfvars"
```

## 🙌 Contributing

Feel free to fork this repository and submit pull requests for improvements, bug fixes, or additional features.

## 📄 License

This project is licensed under the MIT License.

---

Created by [akash66sheoran](https://github.com/akash66sheoran) • Happy Terraforming! ✨

