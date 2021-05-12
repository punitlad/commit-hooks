#!/bin/bash

help() {
  echo "commit_message checker"
  echo
  echo "   check           validates whether the commit message contains the input expected matcher"
  echo "   prepend         prepends commit message with input message"
  echo "   verify          verifies signature of commits between origin/main and HEAD"
  echo
  exit 1
}

if [ "$1" == "check" ]; then
  ./commands/check.sh $2
elif [ "$1" == "prepend" ]; then
  ./commands/prepend.sh $2
elif [ "$1" == "verify" ]; then
  ./commands/verify.sh
else 
  echo "Error. Invalid type $1"
  help
fi