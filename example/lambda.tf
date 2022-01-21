module "go_lambda_packer" {
  source      = "../"
  source_path = "${path.module}/my-lambda"
  output_path = "${path.module}/my-lambda/my-lambda.zip"
}

resource "aws_iam_role" "my_lambda" {
  name = "my-lambda-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "my_lambda" {
  filename         = module.go_lambda_packer.output_path
  function_name    = "my-lambda-function"
  role             = aws_iam_role.my_lambda.arn
  handler          = "my-lambda"
  source_code_hash = module.go_lambda_packer.source_code_hash
  runtime          = "go1.x"

  environment {
    variables = {
      foo = "bar"
    }
  }
}
