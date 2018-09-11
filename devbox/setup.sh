#!/bin/bash
set -o errexit
set -o pipefail
IFS=$'\n\t'

readonly ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export OPTS="$1"

# Using bash infinity: https://github.com/niieani/bash-oo-framework
source "$ROOT_DIR/lib/slog.sh"

##TODO
# generate a private-public key pair if not present already
# ask user to add the public key in authorized keys of root user on the remote box
# exit out if no keys present

__bootstrap_desktop() {
  log_info "Setting up desktop"
  local envs=""
  envs="$envs -e ANSIBLE_STDOUT_CALLBACK=debug"
  local cmd="docker run  \
    --rm \
    -v $(pwd):/ansible \
    $envs \
    ric03uec/cansible:master \
    -vv \
    -i /ansible/hosts \
    /ansible/bootstrap_desktop.yml"
  eval "$cmd"
}

__bootstrap_remote() {
  log_info "Setting up remote machine(s)"

  local envs=""
  envs="$envs -e ANSIBLE_STDOUT_CALLBACK=debug"

  local cmd="docker run  \
    --rm \
    -v $(pwd):/ansible \
    $envs \
    ric03uec/cansible:master \
    -vv \
    -i /ansible/hosts \
    /ansible/bootstrap_system.yml"
  log_info "Executing $cmd"
  eval "$cmd"
}

__print_help() {
  echo "
  Usage:
    ./setup.sh <command>

  Commmands:
    remote          Run Shippable installation
    desktop         Run silent upgrade without any prompts
    help            Print this message
  "
  exit 0
}

main() {
  log_info "Configuring development machine(s)"
  if [ -z "$OPTS" ]; then
    log_warning "No options specified for setup."
    __print_help
    exit 0
  elif [ "$OPTS" == "remote" ]; then
    __bootstrap_remote
    exit 0
  elif [ "$OPTS" == "desktop" ]; then
    __bootstrap_desktop
    exit 0
  else
    log_error "Invalid options: $OPTS"
    __print_help
    exit 1
  fi
}

main
