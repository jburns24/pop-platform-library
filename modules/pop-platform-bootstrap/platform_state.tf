#trivy:ignore:avd-aws-0086 - TODO: Implement ACL
#trivy:ignore:avd-aws-0087 - TODO: Implement public access block
#trivy:ignore:avd-aws-0091 - TODO: S3 Access Block should Ignore Public Acl
#trivy:ignore:avd-aws-0093 - TODO: S3 Access block should restrict public bucket to limit access
#trivy:ignore:avd-aws-0090 - TODO: S3 Data should be versioned
#trivy:ignore:avd-aws-0094 - TODO: S3 buckets should each define an aws_s3_bucket_public_access_block
#trivy:ignore:s3-bucket-logging - TODO: S3 bucket should have logging enabled
resource "aws_s3_bucket" "pop-platform_terraform_state_bucket" {
  bucket = "pop-platform-${var.env}-pop-s3-state-bucket${var.name_suffix}"

  timeouts {
    create = "10m"
    read   = "10m"
    update = "10m"
    delete = "10m"
  }
}

#trivy:ignore:avd-aws-0132 - TODO: S3 encryption should use Customer Managed Keys
resource "aws_s3_bucket_server_side_encryption_configuration" "pop-platform_terraform_state_bucket_sse" {
  bucket = aws_s3_bucket.pop-platform_terraform_state_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

#trivy:ignore:avd-aws-0024 - TODO: Point in time recovery should be enabled to protect DynamoDB table
#trivy:ignore:avd-aws-0025 - TODO: DynamoDB tables should use at rest encryption with a Customer Managed Key
resource "aws_dynamodb_table" "pop-platform_terraform_locks" {
  name         = "pop-platform_${var.env}_terraform_locks${var.name_suffix}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
