#!/bin/bash

if ! echo "$1" | grep -E "test";then
  echo "Your commit message must contain the word test"
  exit 1
fi

