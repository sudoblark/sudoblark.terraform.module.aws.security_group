terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.61.0"
    }
  }
  required_version = "~> 1.5.0"
}

provider "aws" {
  region = "eu-west-2"
}

module "security_group" {
  source              = "github.com/sudoblark/sudoblark.terraform.module.aws.security_group?ref=1.0.0"
  environment         = var.environment
  application_name    = var.application_name
  raw_security_groups = local.raw_security_groups
  vpc_config          = data.aws_vpc.vpc.id
}