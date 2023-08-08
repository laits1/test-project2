#!/bin/sh
export GCLOUD_PATH="/usr/bin/gcloud" # Update this with your actual path
export GCP_ZONE="asia-northeast3-a" # Update this with your actual zone

${GCLOUD_PATH} compute instances create gcloud-vm --machine-type=e2-medium --zone=${GCP_ZONE}

