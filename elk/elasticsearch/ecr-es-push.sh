#!/bin/bash
#usage: ./ecr-es-push.sh [(1) repo] [(2) acc_id] [(3) region] [(4) tag] [(5) profile] 

set -e
REPO_NAME=$1
ACC_ID=$2
TAG=$4
ECR_URL="${ACC_ID}".dkr.ecr.eu-west-1.amazonaws.com

#aws ecr login flow 
ECR_LOGGING_CMD="$(aws ecr get-login --no-include-email --region $3 --profile $5)"
eval "${ECR_LOGGING_CMD}"

docker build -t "$REPO_NAME" .
docker tag "$REPO_NAME":"$TAG" "$ECR_URL"/"$REPO_NAME":"$TAG"
docker push "$ECR_URL"/"$REPO_NAME":"$TAG"
