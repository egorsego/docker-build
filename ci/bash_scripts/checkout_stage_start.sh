#!/bin/bash

curl "https://api.GitHub.com/repos/egorsego/docker-build/statuses/$GIT_COMMIT?access_token=b350185424351d434b105ff242d79de170fcc8e8 " \
-H "Content-Type: application/json" \
-X POST \
-d "{\"state\": \"pending\", \"description\": \"Jenkins-CI: Checkout Stage Started\", \"target_url\": \"192.168.242.43/job/pr_test/${env.BUILD_NUMBER}/console\"}"