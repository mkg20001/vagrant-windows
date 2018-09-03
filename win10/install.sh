#!/bin/bash

VBoxManage \
  unattended install \
  --iso="$PWD/$ISO" \
  --user=vagrant \
  --password=vagrant \
  --full-user-name="Vagrant Windows Box" \
  --install-additions \
  --locale=de_DE \
  --country=DE \
  --time-zone=Europe/Berlin \
  --hostname=termivm10.mkg20001.io \
  --post-install-command '@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "$setupurl = '"'$SETUP_URL'"'; iex ((New-Object System.Net.WebClient).DownloadString('"'$SETUP_URL/entry.ps1'"'))"' \
  "$VM_NAME"
