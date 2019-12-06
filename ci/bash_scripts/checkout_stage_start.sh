#!/bin/bash

TOKEN=$1

curl "https://api.GitHub.com/repos/egorsego/docker-build/statuses/$GIT_COMMIT?access_token=$TOKEN" \
-H "Content-Type: application/json" \
-X POST \
-d "{\"state\": \"pending\", \"description\": \"Jenkins-CI: Checkout Stage Started\", \"target_url\": \"192.168.242.43/job/pr_test/${env.BUILD_NUMBER}/console\"}"