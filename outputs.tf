output "output_path" {
  description = "Zip file path."
  value       = data.external.go_lambda_packer.result.zip
}

