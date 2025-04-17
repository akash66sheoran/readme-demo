locals {
  default_tags = {
    Workspace            = terraform.workspace
    Terraform   = "true"
    Environment = var.environment
    Code        = "https://github.com/kar-par/PAR-platform-tf-infra.git"
    MaintainedBy = var.maintainedBy
    Application = var.application
  }
}