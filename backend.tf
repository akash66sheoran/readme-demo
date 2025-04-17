# terraform {
#   backend "s3" {
#     bucket         = "tod-terraform-state-store"
#     key            = "terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#     workspace_key_prefix = "tf-linux-ec2-workspaces"
#     dynamodb_table = "par-terraform-state-lock"
#   }
# }