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

verify() {
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
    echo "Commits missing signature:$UNSIGNED. All commits must be signed. "
  fi
  if [[ $INCORRECT_AUTHOR != "" ]]; then
    echo "Commit author and signature names are different:$INCORRECT_AUTHOR. Commits should be signed by the same author."
  fi
  if [[ $INCORRECT_AUTHOR != "" || $UNSIGNED != "" ]]; then
    exit 1
  fi
}

if [ "$1" == "check" ]; then
  ./commands/check.sh $2
elif [ "$1" == "prepend" ]; then
  ./commands/prepend.sh $2
elif [ "$1" == "verify" ]; then
  verify  
else 
  echo "Error. Invalid type $1"
  display_help
fi