#!/bin/bash

set -e

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

if [ -z "$SETUP_URL" ]; then
  export SETUP_URL=https://raw.github.com/mkg20001/vagrant-windows/master/setup
else # if you're changing the scripts launch a local webserver to serve setup/ with e.g. https://npm.im/http-server and add it's address here
  log "Using custom setup url: $SETUP_URL"
fi

MAIN=$PWD
cd "$TYPE"

ISO=$(dir -w 1 | grep "iso$")

if [ -z "$ISO" ]; then
  log "Please put the $TYPE ISO into this directory: $PWD" 2>&1
  exit 2
fi

if VBoxManage showvminfo "$VM_NAME" > /dev/null 2> /dev/null; then # if vm exists, delete
  log "Removing old instance of $VM_NAME..."
  VBoxManage unregistervm "$VM_NAME" --delete
fi

# Import
log "Importing vm $VM_NAME..."
VBoxManage import "$VM_NAME.ova"

# Run OS-specific install steps
. install.sh

# Start
VBoxManage startvm "$VM_NAME" --type=headless
sleep 10s

# Wait
echo "Waiting for setup to complete and VM to shut down..."
while ! VBoxManage showvminfo "$VM_NAME" --machinereadable --details | grep VMState= | grep poweroff > /dev/null 2> /dev/null; do
  echo -n .
  sleep 10s
done
echo " ok"

# Post-cleanup (detach install drives)
VBoxManage storageattach "$VM_NAME" --storagectl SATA --port 1 --medium emptydrive
VBoxManage storageattach "$VM_NAME" --storagectl SATA --port 2 --medium none
VBoxManage storagectl "$VM_NAME" --name Floppy --remove

# Vagrant package
vagrant package --base "$VM_NAME" --output "$MAIN/$TYPE.box" --vagrantfile "$PWD/Vagrantfile"
