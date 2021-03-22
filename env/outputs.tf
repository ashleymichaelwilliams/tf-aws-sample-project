//--------------------------------------------------------------------
// Output Variables


output "bucket_name" {
  value = aws_s3_bucket.bucket.id

  description = "The name of the bucket"
}


output "bucket_arn" {
  value = aws_s3_bucket.bucket.arn

  description = "The ARN of the bucket"
}


output "bucket_domain_name" {
  value = aws_s3_bucket.bucket.bucket_domain_name

  description = "The bucket domain name"
}


output "bucket_regional_domain_name" {
  value = aws_s3_bucket.bucket.bucket_regional_domain_name

  description = "The bucket region-specific domain name"
}


output "hosted_zone_id" {
  value = aws_s3_bucket.bucket.hosted_zone_id

  description = "The Route 53 Hosted Zone ID for this bucket's region"
}


output "region" {
  value = aws_s3_bucket.bucket.region

  description = "The AWS region this bucket resides in."
}


output "website_endpoint" {
  value = aws_s3_bucket.bucket.website_endpoint

  description = "The website endpoint, if the bucket is configured with a website."
}


output "website_domain" {
  value = aws_s3_bucket.bucket.website_domain

  description = "The domain of the website endpoint, if the bucket is configured with a website."
}
