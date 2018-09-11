#!/bin/bash
set -o errexit
set -o pipefail
IFS=$'\n\t'

readonly ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Using bash infinity: https://github.com/niieani/bash-oo-framework
#source "$ROOT_DIR/lib/oo-bootstrap.sh"

# bash infinity based imports
#import util/log
#import util/exception
##############################
## parse args to process in two modes: local vs devbox
## local will install docker, get IP of the machine and use docker container to
## ssh into the machine and run the commands
## syntax
## ./setup.sh <mode> [local|devbox]

##TODO
# generate a private-public key pair if not present already
# ask user to add the public key in authorized keys of root user on the remote box
# exit out if no keys present

__bootstrap_desktop() {
  local cmd="docker run  \
    --rm \
    -v $(pwd):/ansible \
    -e ANSIBLE_STDOUT_CALLBACK=debug \
    ric03uec/cansible:master \
    -vv \
    -i /ansible/hosts \
    /ansible/bootstrap_desktop.yml"
  eval "$cmd"
}

__bootstrap_system() {
  local cmd="docker run  \
    --rm \
    -v $(pwd):/ansible \
    -e ANSIBLE_STDOUT_CALLBACK=debug \
    ric03uec/cansible:master \
    -vv \
    -i /ansible/hosts \
    /ansible/bootstrap_system.yml"
  eval "$cmd"
}

main() {
  echo "Configuring development machine(s)"
  __bootstrap_system
}

main
