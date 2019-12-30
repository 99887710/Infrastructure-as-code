#!/bin/bash
REPOSITORIES=$(aws ecr --region=$1 --profile=$4 --output=json describe-repositories | jq -r 'map(.[] | .repositoryName ) | join(" ")')
TARGET_TAG="dev-01"
for repo in $REPOSITORIES; do
      aws ecr --region $2 --profile $4 create-repository --repository-name $repo
      TAGS=$(aws ecr --region $1 --profile $4 --output json list-images --repository-name $repo | jq -r 'map(.[] | .imageTag) | join(" ")')
      for tag in $TAGS; do
        if [ $tag == $TARGET_TAG ]
        then
           docker pull $3.dkr.ecr.$1.amazonaws.com/$repo:$tag
           echo "Pull complete"
           docker tag $3.dkr.ecr.$1.amazonaws.com/$repo:$tag $3.dkr.ecr.$2.amazonaws.com/$repo:$tag
           echo "Tag complete"
           docker push $3.dkr.ecr.$2.amazonaws.com/$repo:$tag
           echo "Push complete"
        else
            echo "Skip this image"
        fi   
      done
done
