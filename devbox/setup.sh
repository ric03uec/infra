#!/bin/bash
set -o errexit
set -o pipefail
IFS=$'\n\t'

readonly ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
readonly SETUP_PRIVATE_KEY="$ROOT_DIR/keys/setupKey"
readonly SETUP_PUBLIC_KEY="$ROOT_DIR/keys/setupKey.pub"
export OPTS="$1"

source "$ROOT_DIR/lib/slog.sh"



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

__generate_ssh_keys() {
  if [ -f "$SETUP_PRIVATE_KEY" ] && [ -f "$SETUP_PUBLIC_KEY" ]; then
    log_info "Setup SSH keys already present, skipping"
  else
    log_info "SETUP SSH keys not available, generating"
    local _=$(ssh-keygen -t rsa -P "" -f "$SETUP_PRIVATE_KEY")
    log_success "SSH keys successfully generated"
    log_info "Please add the public key to authorized_keys file of remote host"
    local public_key=$(cat "$SETUP_PUBLIC_KEY")
    printf "\n\n%s \n\n" "$public_key"
    log_info "Type Y and enter once this is done"

    read confirmation
    confirmation=$(echo "$confirmation" | awk '{print toupper($0)}')

    if [[ "$confirmation" =~ Y ]]; then
      log_success "Proceeding with installation on the remote host"
    elif [[ "$confirmation" =~ N ]]; then
      log_error "Cannot install on remote host if keys are not copied, exiting"
      rm "$SETUP_PRIVATE_KEY"
      rm "$SETUP_PUBLIC_KEY"
      exit 1
    else
      __process_error "Invalid response, please enter Y or N"
      rm "$SETUP_PRIVATE_KEY"
      rm "$SETUP_PUBLIC_KEY"
      exit 1
    fi
  fi
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
  log_success "Successfully set up remote machine(s)"
}

__config_webserver() {
  log_info "Configuring webserver settings on remote machine(s)"
  local envs=""
  envs="$envs -e ANSIBLE_STDOUT_CALLBACK=debug"

  local cmd="docker run  \
    --rm \
    -v $(pwd):/ansible \
    $envs \
    ric03uec/cansible:master \
    -vv \
    -i /ansible/hosts \
    /ansible/webserver.yml"
  log_info "Executing $cmd"
  eval "$cmd"

  log_info "Successfully set up webserver on remote machine(s)"
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
  ## TODO
  ## manually Run apt-get update && apt-get install python-minimal for ansible to work
  ## on the remote host(s)
  if [ -z "$OPTS" ]; then
    __generate_ssh_keys
    log_warning "No options specified for setup."
    __print_help
    exit 0
  elif [ "$OPTS" == "remote" ]; then
    __generate_ssh_keys
    __bootstrap_remote
    __config_webserver
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
