#!/bin/bash

help() {
  echo "usage: commiterator verify"
  echo 
  echo "Verifies commits are signed with the correct author. Checks between origin/main and HEAD"
  exit 1
}

verify() {
  HASHES=$(git log origin/main..HEAD --format='format:%h;%ae')
  UNSIGNED=""
  for i in $HASHES; do
    # shellcheck disable=SC2207
    i=($(echo "$i" | tr ";" " "))
    HASH=${i[0]}
    AUTHOR=${i[1]}
    git verify-commit "$HASH" &> /dev/null
    if [ $? -eq 1 ]; then
      UNSIGNED="$UNSIGNED $HASH"
    else
      git verify-commit "$HASH" 2>&1 | grep "$AUTHOR" &> /dev/null
      if [ $? -eq 1 ]; then
        INCORRECT_AUTHOR="$INCORRECT_AUTHOR $HASH"
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

if [ "$#" -gt 0 ]; then
  help
  exit 1
fi
verify