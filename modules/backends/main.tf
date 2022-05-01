resource "aws_s3_bucket" "backend" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_acl" "backend_bucket_acl" {
  bucket = aws_s3_bucket.backend.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "backend_bucket_versioning" {
  bucket = aws_s3_bucket.backend.id
  //noinspection HCLUnknownBlockType
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "backend_bucket_pa" {
  bucket = aws_s3_bucket.backend.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true

}

resource "aws_dynamodb_table" "tfstate-table" {
  name         = var.table_name
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}