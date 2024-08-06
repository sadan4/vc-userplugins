#!/usr/bin/env bash

if [[ -z $1 ]]; then
    echo "[ERROR] you need to provide a folder name";
    exit 1;
fi

cd -- $1;
REMOTECOUNT=$(git remote -- | grep -c .);
if [[ $REMOTECOUNT -ne 1 && -z $2 ]]; then
    echo "[ERROR] zero or more than one remote found and no remote name provided"
    exit 1;
fi
REMOTE_NAME=$(git remote --);
if [[ $2 ]]; then
    REMOTE_NAME=$2;
fi
REMOTE_URL=$(git remote get-url -- $REMOTE_NAME)
cd -
git rm --cached $1
git commit -m "fix $1"
git submodule add -- $REMOTE_URL $1
