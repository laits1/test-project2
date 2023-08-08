#!/bin/sh
export GCLOUD_PATH="/usr/bin/gcloud" # Update this with your actual path
export GCP_PROJECT_ID="test-project2-394700" # Update this with your actual project ID

${GCLOUD_PATH} auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS
${GCLOUD_PATH} config set project ${GCP_PROJECT_ID}

