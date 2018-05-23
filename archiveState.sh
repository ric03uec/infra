#!/bin/bash -e
###############################################################
#################### Begin helpers ############################
__process_marker() {
  local prompt="$@"
  echo ""
  echo "# $(date +"%T") #######################################"
  echo "# $prompt"
  echo "##################################################"
}

__process_msg() {
  local message="$@"
  echo "|___ $@"
}

__process_error() {
  local message="$1"
  local error="$2"
  local bold_red_text='\e[91m'
  local reset_text='\033[0m'

  echo -e "$bold_red_text|___ $message$reset_text"
  echo -e "     $error"
}

__process_success() {
  local message="$@"
  local bold_green_text='\e[32m'
  local reset_text='\033[0m'

  echo -e "$bold_green_text|___ $message$reset_text"
}

__check_logsdir() {
  if [ ! -d "$LOGS_DIR" ]; then
    mkdir -p "$LOGS_DIR"
  fi
}

#################### END helpers ##############################
###############################################################
###############################################################
readonly ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
readonly STATE_FILE_NAME="terraform.tfstate"
export STATE_RESOURCE_PATH=""

__validate_state_out_resource() {
  __process_marker "Validating state out resource"

  local state_resource="$1"
  if [ -z "$state_resource" ]; then
    __process_error "No state resource provided, exiting"
    exit 1
  else
    __process_success "State resource defined: $state_resource"
  fi

  local state_resource_path=$(shipctl get_resource_meta $state_resource)

  if [ -d "$state_resource_path" ]; then
    __process_msg "State directory exists: $state_resource_path"
    export STATE_RESOURCE_PATH="$state_resource_path/state"
  else
    __process_error "State directory missing: $state_resource_path"
    exit 1
  fi
}

__archive_state() {
  __process_marker "Archiving state"
  local state_file_path="$ROOT_DIR/$STATE_FILE_NAME"
  local state_file_archive_path="$STATE_RESOURCE_PATH/$STATE_FILE_NAME"

  if [ -f "$state_file_path" ]; then
    __process_msg "Archiving state file: $state_file_path"
    local archive_cmd="cp -vr $state_file_path $state_file_archive_path"
    __process_msg "Executing; $archive_cmd"
    eval "$archive_cmd"
  else
    __process_msg "No state file exists: $state_file_path, skipping"
  fi
}

main() {
  __process_marker "Archiving state"
  __validate_state_out_resource "$@"
  __archive_state
}

main "$@"
