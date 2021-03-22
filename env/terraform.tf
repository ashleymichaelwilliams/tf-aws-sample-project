//--------------------------------------------------------------------
// Terraform Configurations


terraform {
  backend "s3" {
    # The S3 bucket, key and region are handled by a variables.

    # Uncomment if you want to statically set this value.
    #bucket = "s3_bucket_name_here"
    #key    = "some/key/path"
    #region = "us-west-1"
  }

  required_version = ">= 0.14"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 3.32.0"
    }
  }
}
