resource "aws_s3_bucket" "tf_back" {
  bucket = var.bucket_name

   lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name        = var.bucket_tag
  }
}
 
resource "aws_s3_bucket_versioning" "enabled_end" {
  bucket = aws_s3_bucket.tf_back.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "tf_state" {
  name = var.table_name
  hash_key = "LockID"  #hashed column
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID" #column name
    type = "S" #type string
  }
}