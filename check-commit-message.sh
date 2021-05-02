#!/bin/bash

MSG=$(cat .git/COMMIT_EDITMSG) # incoming argument value is .git/COMMIT_EDITMSG
MATCHER=$1 # incoming argument value from pre-commit

if ! echo $MSG | grep -E $MATCHER ;then
  echo "Your commit message must contain the matcher $MATCHER"
  exit 1
fi
