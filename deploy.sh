#!/bin/bash

set -e
echo $GITHUB_AUTH_SECRET > ~/.git-credentials && chmod 0600 ~/.git-credentials
git config --global credential.helper store
git config --global user.email "cncfidbot@users.noreply.github.com"
git config --global user.name "CNCF ID Bot"
git config --global push.default simple

git clone -b master https://github.com/cloudnative-id/cloudnative-id.github.io deployment
rsync -av --delete --exclude ".git" docs/ deployment
cd deployment
git commit -m "rebuilding site on `date`, commit ${TRAVIS_COMMIT} and job ${TRAVIS_JOB_NUMBER}" || true
git push
cd ..
rm -rf deployment
rm -rf docs
