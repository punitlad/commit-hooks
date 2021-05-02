#!/bin/bash

MATCHER=$1 # incoming argument value from pre-commit

MSG=$(cat .git/COMMIT_EDITMSG)
if ! echo $MSG | grep -E $MATCHER ;then
  echo "Your commit message must contain the matcher $MATCHER"
  exit 1
fi
