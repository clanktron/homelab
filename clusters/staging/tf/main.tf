provider "aws" {
    region = "us-govcloud-west"
}

terraform {
    backend "s3" {
        bucket = "castro-staging-terraform-state" 
        key = "default.tfstate"
        region = "us-govcloud-west"
    }
}

module "kubernetes" {
    source = "./kubernetes"
    vpc_cidr_block = "10.240.0.0/16"
}
