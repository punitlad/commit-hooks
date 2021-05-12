#!/bin/bash

prepend() {
  MESSAGE=$(awk -v prepend="$1" '{print prepend $0}' .git/COMMIT_EDITMSG)
  echo $MESSAGE > .git/COMMIT_EDITMSG
  echo "Message updated to: $(cat .git/COMMIT_EDITMSG)"
}

if [ "$#" -ne 1 ]; then
  echo "Error. Prepend value not set"
  exit 1
fi
prepend $1