
/******************************************************************************\
| s3.tf
| Creates the S3 bucket and IAM stuffs
|
| Known Bugs: None
| Estimated Runtime Cost: Low
| Change Log:
| 2018/02/09 - tls - initial version
| 9999/99/99 - xxx - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
|                    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
| Known Issues:
| #99 - 9999/99/99 - xxx - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
\******************************************************************************/


resource "aws_s3_bucket" "chumbucket" {
  bucket = "my-s3-chumbucket"
}

resource "aws_iam_instance_profile" "chumbucket_consumer_profile" {
  name = "chumbucket_consumer_profile"
  roles = ["${aws_iam_role.chumbucket_consumer_role.name}"]
}

resource "aws_iam_role" "chumbucket_consumer_role" {
  name = "ec2role_chumbucket_consumer_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


resource "aws_s3_bucket_policy" "chumbucket" {
  bucket = "${aws_s3_bucket.chumbucket.id}"
  policy =<<POLICY
{
  "Version": "2012-10-17",
  "Id": "CHUMBUCKET_POLICY_20180220",
  "Statement": [
    {
        "Effect": "Allow",
        "Principal":{"AWS":"${aws_iam_role.chumbucket_consumer_role.arn}"},
        "Action": "s3:ListBucket",
        "Resource": "${aws_s3_bucket.chumbucket.arn}"
    },
    {
        "Effect": "Allow",
        "Principal":{"AWS":"${aws_iam_role.chumbucket_consumer_role.arn}"},
        "Action": [
            "s3:GetObject",
            "s3:PutObject",
            "s3:DeleteObject"
        ],
        "Resource": "${aws_s3_bucket.chumbucket.arn}/*"
    },
    {
      "Effect": "Deny",
      "Principal":"*",
      "Action": [
        "*"
      ],
      "Resource": [
        "${aws_s3_bucket.chumbucket.arn}/*"
      ],
      "Condition": {
        "DateLessThan": {
          "aws:TokenIssueTime": "2018-02-21T04:53:28.084Z"
        }
      }
    }
  ]
}
POLICY
}
