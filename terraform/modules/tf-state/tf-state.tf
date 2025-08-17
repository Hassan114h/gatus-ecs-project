data "aws_s3_bucket" "terraform_state" {
  bucket = "hassan-ecs-tf-13445"
}

resource "aws_s3_bucket_versioning" "terraform_bucket_versioning" {
  bucket = data.aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_crypto_conf" {
  bucket = data.aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

