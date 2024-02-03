#!/bin/bash

TARGET_LIBRARY_NAME=/ubuntu-cloudimg/
TARGET_VM_NAME="jammy-server-cloudimg-amd64"
IMAGE_LIST_RESULT=$(govc library.info -json $TARGET_LIBRARY_NAME | jq -e '.[].name == "jammy-server-cloudimg-amd64"')


for IMAGE in $IMAGE_LIST_RESULT
do
    if $IMAGE; then
    echo "Image $TARGET_LIBRARY_NAME$TARGET_VM_NAME has been found"
    govc library.rm $TARGET_LIBRARY_NAME$TARGET_VM_NAME
    break
else
    echo "Image $TARGET_VM_NAME not found."
fi
done

govc library.import ubuntu-cloudimg https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.ova