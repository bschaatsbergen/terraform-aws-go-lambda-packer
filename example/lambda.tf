module "go_lambda_packer" {
  source      = "../"
  source_path = "${path.module}/my-lambda"
  output_path = "${path.module}/my-lambda/my-lambda.zip"
}
