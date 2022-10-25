output "region" {
  value = aws_s3_bucket.tfstate.region
}

output "bucket" {
  value = aws_s3_bucket.tfstate.bucket
}
