#!/bin/bash

TOKEN=$1

curl "https://api.GitHub.com/repos/egorsego/docker-build/statuses/$GIT_COMMIT?access_token=$TOKEN" \
-H "Content-Type: application/json" \
-X POST \
-d "{\"state\": \"success\", \"context\": \"continuous-integration/jenkins\", \"description\": \"Jenkins-CI: Checkout Stage Completed Successfully\", \"target_url\": \"http://192.168.242.43:8080/job/pr_test/$BUILD_NUMBER/console\"}"