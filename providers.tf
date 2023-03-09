terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.27.0"
    }

  }
 backend "s3" {
   bucket         = "baucket9090900"
   key            = "terra-backend/terraform.tfstate"
   region         = "us-east-1"
   dynamodb_table = "back_end"
   encrypt        = true
 }
 
}
provider "aws" {
  region = "us-east-1"
}