#!/bin/bash

# Check if a commit message was provided
if [ -z "$1" ]; then
    echo "Forgot to provide message"
    exit 1
fi

# Add, commit, and push in one go
git add .
git commit -m "$1"
git push
