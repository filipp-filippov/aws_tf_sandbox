resource "aws_s3_bucket" "mgmt" {
  bucket_name = var.bucket_name
}

resource "aws_s3_bucket_acl" "mgmt_bucket_acl" {
  bucket = aws_s3_bucket.mgmt.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "mgmt_bucket_versioning" {
  bucket = aws_s3_bucket.mgmt.id
  //noinspection HCLUnknownBlockType
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "mgmt_bucket_pa" {
  bucket = aws_s3_bucket.mgmt.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true

}

resource "aws_dynamodb_table" "mgmttfstate" {
  name         = var.table_name
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}