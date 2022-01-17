#!/bin/bash

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
  eval "$(jq -r '@sh "export SOURCE_PATH=\(.source_path) OUTPUT_PATH=\(.output_path) INSTALL_DEPENDENCIES=\(.install_dependencies)"')"
  if [[ -z "${SOURCE_PATH}" ]]; then export SOURCE_PATH=none; fi
  if [[ -z "${OUTPUT_PATH}" ]]; then export OUTPUT_PATH=none; fi
  if [[ -z "${INSTALL_DEPENDENCIES}" ]]; then export INSTALL_DEPENDENCIES=none; fi
}

function build_executable() {
  cd ${SOURCE_PATH}

  if $INSTALL_DEPENDENCIES; then 
    go mod verify
    go mod tidy;
  fi

  GOOS=linux go build .
}

function pack_executable() {
  cd - # go back to previous directory
  zip -r ${OUTPUT_PATH} ${SOURCE_PATH}
}

# function build_stable_hash() {
#   sha256sum ${OUTPUT_PATH} | awk '{print $1}'
# }

check_deps
parse_input
build_executable
pack_executable
build_stable_hash

# echo '{"source_path": "my-lambda", "output_path": "my-lambda/my-lambda.zip", "install_dependencies": true}' | ./go_lambda_packer.sh
