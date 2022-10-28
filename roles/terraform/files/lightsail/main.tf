provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Managed-By = "Terraform"
      Group      = "Outline"
    }
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

