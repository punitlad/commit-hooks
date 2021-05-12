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

check() {
  if [ "$#" -ne 1 ]; then
    echo "Error. Matcher not set"
    display_help
  fi

  MATCHER=$1 # incoming argument value from pre-commit

  MSG=$(cat .git/COMMIT_EDITMSG)
  if ! echo $MSG | grep -E $MATCHER ;then
      echo "Your commit message must contain the matcher $MATCHER"
      exit 1
  fi
}

prepend() {
  if [ "$#" -ne 1 ]; then
    echo "Error. Prepend value not set"
    display_help
  fi

  MESSAGE=$(awk -v prepend="$2" '{print prepend $0}' .git/COMMIT_EDITMSG)
  echo $MESSAGE > .git/COMMIT_EDITMSG
  echo "Message updated to: $(cat .git/COMMIT_EDITMSG)"
}

if [ "$1" == "check" ]; then
  check $2
elif [ "$1" == "prepend" ]; then
  prepend $2
elif [ "$1" == "verify" ]; then
  HASHES=$(git log origin/main..HEAD --format='format:%h;%ae')
  UNSIGNED=""
  for i in $HASHES; do
    i=($(echo $i | tr ";" " "))
    HASH=${i[0]}
    AUTHOR=${i[1]}
    git verify-commit $HASH &> /dev/null
    if [ $? -eq 1 ]; then
      UNSIGNED="$UNSIGNED $i"
    else
      git verify-commit $HASH 2>&1 | grep $AUTHOR &> /dev/null
      if [ $? -eq 1 ]; then
        INCORRECT_AUTHOR="$INCORRECT_AUTHOR $i"
      fi
    fi
  done

  if [[ $UNSIGNED != "" ]]; then
    echo "Commits missing signature:$UNVERIFIED. All commits must be signed. "
  fi
  if [[ $INCORRECT_AUTHOR != "" ]]; then
    echo "Commit author and signature names are different:$INCORRECT_AUTHOR. Commits should be signed by the same author."
  fi
  if [[ $INCORRECT_AUTHOR != "" || $UNSIGNED != "" ]]; then
    exit 1
  fi 
else 
  echo "Error. Invalid type $1"
  display_help
fi