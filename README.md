# Terraform AWS Go Lambda Packer

This terraform module allows you to package and deploy a Go based AWS Lambda function including a stable SHA256 source hash.

See: https://docs.aws.amazon.com/lambda/latest/dg/golang-package.html

Features:

- Install dependencies
- Compresses binary into a zip
- Builds a stable base64 SHA256 sum (*under development*)

## Example

```hcl
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
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

The following binaries are required:

- jq
- go
- zip

## Providers

| Name | Version |
|------|---------|
| <a name="provider_external"></a> [external](#provider\_external) | 2.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [external_external.go_lambda_packer](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_install_dependencies"></a> [install\_dependencies](#input\_install\_dependencies) | Whether to install module dependencies. | `bool` | `true` | no |
| <a name="input_output_path"></a> [output\_path](#input\_output\_path) | Path for output file. | `string` | n/a | yes |
| <a name="input_source_path"></a> [source\_path](#input\_source\_path) | Path to root of Go source. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_output_path"></a> [output\_path](#output\_output\_path) | Path of the zip file that contains the Go binanry. |
| <a name="output_source_code_hash"></a> [source\_code\_hash](#output\_source\_code\_hash) | Base64 encoded sha256 sum of the Go binary. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->