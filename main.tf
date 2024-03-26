resource "aws_s3_bucket" "mys3bucket" {
  bucket = var.bucketname
}

resource "aws_s3_bucket_ownership_controls" "bucketowner" {
  bucket = aws_s3_bucket.mys3bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }

}

resource "aws_s3_bucket_public_access_block" "access-block" {
  bucket = aws_s3_bucket.mys3bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "bucket-acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.bucketowner,
    aws_s3_bucket_public_access_block.access-block,
  ]

  bucket = aws_s3_bucket.mys3bucket.id
  acl    = "public-read"
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.mys3bucket.id
  key = "index.html"
  source = "index.html"
  content_type = "text/html"
  acl = "public-read"
}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.mys3bucket.id
  key = "error.html"
  source = "error.html"
  content_type = "text/html"
  acl = "public-read"
}

resource "aws_s3_object" "profile1" {
  bucket = aws_s3_bucket.mys3bucket.id
  key = "profile1.png"
  source = "profile1.png"
  acl = "public-read"
}

resource "aws_s3_object" "profile2" {
  bucket = aws_s3_bucket.mys3bucket.id
  key = "profile2.png"
  source = "profile2.png"
  acl = "public-read"
}

resource "aws_s3_object" "profile3" {
  bucket = aws_s3_bucket.mys3bucket.id
  key = "profile3.png"
  source = "profile3.png"
  acl = "public-read"
}

resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.mys3bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
  depends_on = [ aws_s3_bucket_acl.bucket-acl ]
}