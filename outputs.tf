output "source_code_hash" {
  description = "Base64 encoded sha256 sum of the zip file."
  value       = data.external.go_lambda_packer.result.source_code_hash
}

output "output_path" {
  description = "Path of the zip file that contains the Go binary."
  value       = data.external.go_lambda_packer.result.output_path
}
