#!/bin/bash

help() {
  echo "commiterator"
  echo
  echo "   check           validates whether the commit message contains the input expected matcher"
  echo "   prepend         prepends commit message with input message"
  echo "   verify          verifies signature of commits between origin/main and HEAD"
  echo
  exit 1
}

if [ "$1" == "check" ]; then
  shift; ./commands/check.sh $@
elif [ "$1" == "prepend" ]; then
  shift; ./commands/prepend.sh $@
elif [ "$1" == "verify" ]; then
  shift; ./commands/verify.sh $@
else 
  echo "Error. Invalid command $1. Available commands are {check, prepend, verify}"
  help
fi