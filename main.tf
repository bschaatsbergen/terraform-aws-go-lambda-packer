data "external" "go_lambda_packer" {
  program = ["bash", "${path.module}/scripts/go_lambda_packer.sh"]

  query = {
    source_path          = var.source_path
    output_path          = var.output_path
    install_dependencies = var.install_dependencies
  }
}