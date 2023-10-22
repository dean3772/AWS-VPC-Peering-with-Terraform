provider "aws" {
  region = "us-east-1"  
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "my-unique1820234-terraform-state-bucket" 
  acl    = "private"

  versioning {
    enabled = true
  }
}
