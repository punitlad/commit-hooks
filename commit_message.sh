#!/bin/bash

display_help() {
  echo "commit_message checker"
  echo
  echo "   check           validates whether the commit message contains the input expected matcher"
  echo "   prepend         prepends commit message with input message"
  echo "   verify          verifies signature of commits between origin/main and HEAD"
  echo
  exit 1
}

if [ "$1" == "check" ]; then
  if [ "$#" -ne 2 ]; then
    echo "Error. Expected 2 arguments"
    display_help
  fi

  MATCHER=$2 # incoming argument value from pre-commit

  MSG=$(cat .git/COMMIT_EDITMSG)
  if ! echo $MSG | grep -E $MATCHER ;then
      echo "Your commit message must contain the matcher $MATCHER"
      exit 1
  fi
elif [ "$1" == "prepend" ]; then
  if [ "$#" -ne 2 ]; then
    echo "Error. Expected 2 arguments"
    display_help
  fi

  MESSAGE=$(awk -v prepend="$2" '{print prepend $0}' .git/COMMIT_EDITMSG)
  echo $MESSAGE > .git/COMMIT_EDITMSG
  echo "Message updated to: $(cat .git/COMMIT_EDITMSG)"
elif [ "$1" == "verify" ]; then
  HASHES=$(git log origin/main..HEAD --format=format:%h)
  UNVERIFIED=""
  for i in $HASHES; do
    git verify-commit $i &> /dev/null
    if [ $? -eq 1 ]; then
      UNVERIFIED="$UNVERIFIED $i"
    fi
  done

  if [[ $UNVERIFIED != "" ]]; then
    echo "Failed verifing signature on commits:$UNVERIFIED. All commits must be signed. "
    exit 1
  fi
else 
  echo "Error. Invalid type $1"
  display_help
fi