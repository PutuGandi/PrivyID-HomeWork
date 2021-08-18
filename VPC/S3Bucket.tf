resource "aws_s3_bucket" "gandiMyId" {
  bucket = var.BUCKET_NAME
  acl    = "private"

  tags = {
    Name        = "gandiMyId"
    Environment = "Dev"
  }
}