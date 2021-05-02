#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "check_commit_message requires a two arguments stating type and regular expression"
    echo "possible types: check"
    exit 1
fi

if [ "$1" == "check" ]; then
    MATCHER=$2 # incoming argument value from pre-commit

    MSG=$(cat .git/COMMIT_EDITMSG)
    if ! echo $MSG | grep -E $MATCHER ;then
        echo "Your commit message must contain the matcher $MATCHER"
        exit 1
    fi
else 
    echo "check_commit_message requires a two arguments stating type and regular expression"
    echo "possible types: check"
    exit 1
fi