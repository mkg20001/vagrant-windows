#!/bin/bash

l=$(echo "$1" | tr '[:upper:]' '[:lower:]') # convert name to lowercase

rm -f "$l/$1.ova"
VBoxManage export "$1" -o "$l/$1.ova" --options nomacs
