#!/bin/bash

MSG=$(cat $1) # incoming argument value is .git/COMMIT_EDITMSG

if ! echo $MSG | grep -E "test";then
  echo "Your commit message must contain the word test"
  exit 1
fi
