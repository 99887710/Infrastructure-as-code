#!/bin/bash
#usage: ./ecr-image-migrate.sh [(1) src] [(2) dst] [(3) acc_id] [(4) repo] [(5) src_tag] [(6) dst_tag] [(6) profile] 

aws ecr get-login --no-include-email --profile $7
#aws ecr login flow (both source, destination)
SRC_ECR_LOGGING_CMD="$(aws ecr get-login --no-include-email --region $1 --profile $7)"
eval "${SRC_ECR_LOGGING_CMD}"
DST_ECR_LOGGING_CMD="$(aws ecr get-login --no-include-email --region $2 --profile $7)"
eval "${DST_ECR_LOGGING_CMD}"

docker pull {{Your AWS Account Number}}.dkr.ecr.eu-west-1.amazonaws.com/$4:$5
echo "Pull complete"
docker tag $3.dkr.ecr.$1.amazonaws.com/$4:$5 $3.dkr.ecr.$2.amazonaws.com/$4:$6
echo "Tag complete"
docker push $3.dkr.ecr.$2.amazonaws.com/$4:$6
echo "Push complete"
echo "Image Migration Done!"