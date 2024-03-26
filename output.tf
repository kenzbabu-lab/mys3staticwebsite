output "website_url" {
  value = aws_s3_bucket.mys3bucket.website_endpoint
}