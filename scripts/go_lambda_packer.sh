#!/bin/bash

# echo '{"source_path": "example/my-lambda", "output_path": "example/my-lambda/my-lambda.zip", "install_dependencies": true}' | scripts//go_lambda_packer.sh

function error_exit() {
  echo "$1" 1>&2
  exit 1
}

function check_deps() {
  test -f $(which go) || error_exit "go command not detected in path, please install it"
  test -f $(which jq) || error_exit "jq command not detected in path, please install it"
  test -f $(which zip) || error_exit "zip command not detected in path, please install it"
}

function parse_input() {
  eval "$(jq -r '@sh "export source_path=\(.source_path) output_path=\(.output_path) install_dependencies=\(.install_dependencies)"')"
  if [[ -z "${source_path}" ]]; then export source_path=none; fi
  if [[ -z "${output_path}" ]]; then export output_path=none; fi
  if [[ -z "${install_dependencies}" ]]; then export install_dependencies=none; fi
} &> /dev/null

function build_executable() {
  cd ${source_path} || exit

  if $install_dependencies; then
    go mod verify
    go mod tidy;
  fi

  GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build .

  cd - # go back to previous directory
} &> /dev/null

check_deps
parse_input
build_executable
echo "{}"
