terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

 backend "s3" {
    bucket         = "my-eks-shailesh"         # 🔁 S3 bucket name (must exist)
    key            = "eks-cluster/terraform.tfstate"  # 📄 path to tfstate file inside the bucket
    region         = "us-west-2"                      # 🌍 AWS region
    dynamodb_table = "terraform-lock-table"           # 🔒 DynamoDB table for state locking
    encrypt        = true
}
}



provider "aws" {
  region  = "us-west-2"
  
}

# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name_prefix}-vpc"
  }
}
variable "name_prefix" {
  default = "test"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
