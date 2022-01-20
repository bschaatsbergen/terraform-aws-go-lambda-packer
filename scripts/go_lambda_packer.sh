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
}

function build_executable() {
  cd ${source_path}

  if $install_dependencies; then 
    go mod verify
    go mod tidy;
  fi

  GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build .
}

function pack_executable() {
  cd - # go back to previous directory
  zip -r ${output_path} ${source_path} --junk-paths
}

function build_stable_base64_hash() {
  executable=$(find . -executable -type f) # find executable files in current directory

  sha256=$(sha256sum ${executable} | awk '{print $1}')
  # echo "DEBUG: sha256 ${sha256}" 1>&2

  base64sha256=$(echo ${sha256} | base64)
  # echo "DEBUG: base64sha256 ${base64sha256}" 1>&2
}

function produce_output() {
  jq -n \
    --arg source_code_hash "$base64sha256" \
    --arg output_path "$output_path" \
    '{"source_code_hash":$source_code_hash,"output_path":$output_path}'
}

check_deps
parse_input
build_executable
build_stable_base64_hash
pack_executable
produce_output
