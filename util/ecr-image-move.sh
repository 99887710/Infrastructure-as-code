#usage: ./ecr-image-move.sh [(1) repo] [(2) tag]

aws ecr get-login --no-include-email --profile voodoo_dev
aws ecr get-login --no-include-email --profile voodoo_prod

SRC_ECR_LOGGING_CMD="$(aws ecr get-login --no-include-email --region eu-west-1 --profile voodoo_dev)"
eval "${SRC_ECR_LOGGING_CMD}"
DST_ECR_LOGGING_CMD="$(aws ecr get-login --no-include-email --region eu-west-2 --profile voodoo_prod)"
eval "${DST_ECR_LOGGING_CMD}"

docker pull {{Your Source AWS Account Numbe}}.dkr.ecr.eu-west-1.amazonaws.com/$1:$2
echo "Pull complete"
docker tag {{Your Source AWS Account Numbe}}.dkr.ecr.eu-west-1.amazonaws.com/$1:$2 {{Your Destination AWS Account Numbe}}.dkr.ecr.eu-west-2.amazonaws.com/$1:$2
echo "Tag complete"
docker push {{Your Destination AWS Account Numbe}}.dkr.ecr.eu-west-2.amazonaws.com/$1:$2
echo "Push complete"
echo "Image Migration Done!"