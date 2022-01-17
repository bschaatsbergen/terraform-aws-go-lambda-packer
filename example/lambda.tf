module "go_lambda_packer" {
    source      = "../"
    src_dir     = "${path.module}/my-lambda"
    output_path = "${path.module}/my-lambda/my-lambda.zip"
}