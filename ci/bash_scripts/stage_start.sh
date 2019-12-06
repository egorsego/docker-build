#!/bin/bash

TOKEN=$1
CONTEXT=$2

curl "https://api.GitHub.com/repos/egorsego/docker-build/statuses/$GIT_COMMIT?access_token=$TOKEN" \
-H "Content-Type: application/json" \
-X POST \
-d "{\"state\": \"pending\", \"context\": \"Jenkins-CI: $CONTEXT Stage\", \"target_url\": \"http://192.168.242.43:8080/job/pr_test/$BUILD_NUMBER\"}"