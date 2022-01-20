# Terraform AWS Go Lambda Packer

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

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