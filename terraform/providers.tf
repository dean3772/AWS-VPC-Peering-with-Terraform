// Backend configuration for Terraform state management
terraform {
  backend "s3" {
    bucket = "my-unique1820234-terraform-state-bucket" 
    key    = "lypeerstate"
    region = "us-east-1"  // Make sure this is the same region where the bucket was created
  }
}

// Declare AWS Providers for different regions
// Providers
provider "aws" {
  region = "us-east-1"
  alias  = "use"
}

provider "aws" {
  region = "us-west-2"
  alias  = "usw"
}