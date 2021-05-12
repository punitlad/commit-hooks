#!/bin/bash

help() {
  echo "usage: commit_message prepend (string_value)"
  echo 
  echo "Prepends the commit message with the supplied value. Uses the value present in .git/COMMIT_EDITMSG"
  exit 1
}

prepend() {
  MESSAGE=$(awk -v prepend="$1" '{print prepend $0}' .git/COMMIT_EDITMSG)
  echo $MESSAGE > .git/COMMIT_EDITMSG
  echo "Message updated to: $(cat .git/COMMIT_EDITMSG)"
}

if [ "$#" -ne 1 ]; then
  echo "Error. Prepend value not set"
  help
  exit 1
fi
prepend $1