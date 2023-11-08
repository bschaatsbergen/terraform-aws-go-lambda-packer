data "external" "go_lambda_packer" {
  program = ["bash", "${path.module}/scripts/go_lambda_packer.sh"]

  query = {
    source_path          = var.source_path
    output_path          = var.output_path
    install_dependencies = var.install_dependencies
  }
}

data "archive_file" "zip" {
  type        = "zip"
  source_dir = "${var.source_path}/"
  output_path = "${path.module}/event-parser.zip"

  depends_on = [data.external.go_lambda_packer]
}
