#!/bin/bash

curl "https://api.GitHub.com/repos/egorsego/docker-build/statuses/$GIT_COMMIT?access_token=3bf32d587b844411493edee30f31122fd6c1ded6" \
-H "Content-Type: application/json" \
-X POST \
-d "{\"state\": \"pending\", \"description\": \"Jenkins-CI: Checkout Stage Started\", \"target_url\": \"192.168.242.43/job/pr_test/${env.BUILD_NUMBER}/console\"}"