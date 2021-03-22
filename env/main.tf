//--------------------------------------------------------------------
// Declared Resources


# Construct Naming Prefix as a Local Variable
locals {
  BASE_PREFIX   = lower(replace(replace("${var.metadata.team}-${var.metadata.product}-${var.metadata.environment}", ".", "-"), " ", "_"))
  BUCKET_PREFIX = lower("${var.metadata.organization}-${local.BASE_PREFIX}")
}



### AWS S3 Bucket Resources

resource "aws_s3_bucket" "bucket" {
  bucket = "${local.BUCKET_PREFIX}-${var.metadata.shard_id}"
  acl    = "private"

  versioning {
    enabled = var.s3_versioning
  }

  tags = { for key, value in var.metadata : lower(key) => lower(replace(replace(value, ".", "-"), " ", "_")) }
}


resource "aws_iam_role" "bucket_role" {
  name = "${local.BUCKET_PREFIX}-${var.metadata.shard_id}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}


resource "aws_iam_policy" "bucket_policy" {
  name = "${local.BUCKET_PREFIX}-${var.metadata.shard_id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:Get*",
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.bucket.arn}/*"
      ]
    }
  ]
}
POLICY
}


resource "aws_iam_role_policy_attachment" "bucket_policy" {
  role       = aws_iam_role.bucket_role.name
  policy_arn = aws_iam_policy.bucket_policy.arn
}
