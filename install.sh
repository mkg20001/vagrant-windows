#!/bin/bash

case "$1" in
  win7)
    TYPE="win7"
    VM_NAME="Win7"
    ;;
  win10)
    TYPE="win10"
    VM_NAME="Win10"
    ;;
  *)
    echo "Usage: $0 {win7, win10}"
    exit 2
esac

log() {
  echo "$(date): $@"
}

MAIN=$PWD
cd "$TYPE"

if VBoxManage showvminfo "$VM_NAME" > /dev/null 2> /dev/null; then # if vm exists, delete
  log "Removing old instance of $VM_NAME..."
  VBoxManage unregistervm "$VM_NAME" --delete
fi

log "Importing vm $VM_NAME..."
VBoxManage import "$VM_NAME.ova"
