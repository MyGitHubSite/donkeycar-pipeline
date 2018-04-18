

output "s3_bucket_name" {
  value = "${aws_s3_bucket.chumbucket.bucket}"
}

output "s3_iam_instance_profile_name" {
  value = "${aws_iam_instance_profile.chumbucket_consumer_profile.name}"
}
