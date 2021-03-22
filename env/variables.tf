//--------------------------------------------------------------------
// Declared Variables


variable "metadata" {
  type = map(any)

  description = "Common Tags to apply across resources. (*REQUIRED*)"
}


variable "region" {
  type    = string
  default = "us-west-1"

  description = "provide the region for resource(s) to be created."
}


variable "s3_versioning" {
  type    = bool
  default = false

  description = "Enable S3 bucket versioning."
}
