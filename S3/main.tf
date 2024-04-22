resource "aws_s3_bucket" "wtorkowy_kubełek" {
    bucket = "dzieje-sie-images"
}

resource "aws_s3_bucket" "środowy_kubełek" {
    bucket = "dzieje-sie-packages"
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.wtorkowy_kubełek.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_public_access_block" "packagowy" {
  bucket = aws_s3_bucket.środowy_kubełek.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket_policy" "Read_Only_Permission" {
  bucket = aws_s3_bucket.wtorkowy_kubełek.id
  policy = data.aws_iam_policy_document.Read_Only_Permission.json
}

data "aws_iam_policy_document" "Read_Only_Permission" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.wtorkowy_kubełek.arn,
      "${aws_s3_bucket.wtorkowy_kubełek.arn}/*",
    ]
  }
}


