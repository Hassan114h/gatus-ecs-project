terraform {
  backend "s3" {
    bucket       = "hassan-ecs-tf-13445"
    key          = "tf-infra/terraform.tfstate"
    region       = "eu-west-1"
    encrypt      = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.7.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}
