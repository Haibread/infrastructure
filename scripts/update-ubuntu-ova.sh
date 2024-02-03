#!/bin/bash

TARGET_LIBRARY_NAME=/ubuntu-cloudimg/
TARGET_VM_NAME="jammy-server-cloudimg-amd64.ova"
IMAGE_LIST=$(govc library.info -json $TARGET_LIBRARY_NAME | jq)

if grep-q "$IMAGE_LIST" <<< "$TARGET_VM_NAME" ; then
    govc library.rm $TARGET_LIBRARY_NAME$TARGET_VM_NAME
else
    echo "VM $TARGET_VM_NAME not found."
fi

govc library.import ubuntu-cloudimg https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.ova