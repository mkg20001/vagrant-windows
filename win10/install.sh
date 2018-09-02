#!/bin/bash

VBoxManage \
  unattended install \
  --iso="$PWD/$ISO" \
  --user=vagrant \
  --password=vagrant \
  --full-user-name="Vagrant Windows Box" \
  --install-additions \
  --hostname=vagrant.localhost \
  --start-vm=headless \
  "$VM_NAME"
