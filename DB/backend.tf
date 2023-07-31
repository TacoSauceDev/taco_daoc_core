terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "terraform-s3-701513128844"
    key    = "terraform/tacodaoc-db/terraform.tfstate"
    region = "us-west-2"
  }
}

provider "aws" {
    default_tags {
      tags = {
        "git_repo" = var.git_repo
      }
    }
}