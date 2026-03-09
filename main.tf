#IAM Role for Beanstalk

resource "aws_iam_role" "beanstalk" {
  name = "${var.app_name}-beanstalk"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

}

resource "aws_iam_role_policy_attachment" "beanstalk" {
  role       = aws_iam_role.beanstalk.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_instance_profile" "beanstalk" {
  name = "${var.app_name}-beanstalk"
  role = aws_iam_role.beanstalk.name
}

# S3 — Upload application versions

resource "aws_s3_bucket" "app_versions" {
  bucket = "${var.app_name}-versions-${random_id.bucket_suffix.hex}"
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_object" "blue_app" {
  bucket = aws_s3_bucket.app_versions.id
  key    = "blue/app.zip"
  source = "${path.module}/app v1/app.zip"
  etag   = filemd5("${path.module}/app v1/app.zip")
}

resource "aws_s3_object" "green_app" {
  bucket = aws_s3_bucket.app_versions.id
  key    = "green/app.zip"
  source = "${path.module}/app v2/app.zip"
  etag   = filemd5("${path.module}/app v2/app.zip")
}

# Elastic Beanstalk Application

resource "aws_elastic_beanstalk_application" "app" {
  name        = var.app_name
  description = "Blue-Green Deployment Demo using Terraform"
}

#Application Version

resource "aws_elastic_beanstalk_application_version" "blue" {
  name        = "blue-${var.blue_version}"
  application = aws_elastic_beanstalk_application.app.name
  description = "Blue version"
  bucket      = aws_s3_bucket.app_versions.id
  key         = aws_s3_object.blue_app.key
}

resource "aws_elastic_beanstalk_application_version" "green" {
  name        = "green-${var.green_version}"
  application = aws_elastic_beanstalk_application.app.name
  description = "Green version"
  bucket      = aws_s3_bucket.app_versions.id
  key         = aws_s3_object.green_app.key
}
