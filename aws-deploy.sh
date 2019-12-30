#!/bin/bash

# if no command line arg given
# set resource to Unknown
if [ -z $1 ]
then
  resource="*** Unknown resource ***"
elif [ -n $1 ]
then
# otherwise make first arg as a resource
  resource=$1
fi

deploy_aws_resource(){
    aws cloudformation deploy \
        --template-file $1 \
        --stack-name $2 \
        --capabilities $3 \
        --profile $4 \
        --region $5 \
        --parameter-overrides $(cat $6 | tr "\n\r" " ")         
}

deploy_aws_resource_no_params(){
    aws cloudformation deploy \
        --template-file $1 \
        --stack-name $2 \
        --capabilities $3 \
        --profile $4 \
        --region $5 
}

# Target deployment aws region
# https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RegionsAndAvailabilityZones.html

# EU (Frankfurt): eu-central-1
# EU (Ireland): eu-west-1
# EU (London): eu-west-2
# EU (Paris): eu-west-3
# EU (Stockholm): eu-north-1

deploy_to_region="{{put the target deployment region here}}"

deploy_profile="{{put your aws profile here}}"

# use case statement to deploy specified resource
case $resource in

### Networking resources
    
   "network/vpc") 
                echo "Start deploying $resource ..."
                templatePath="network/vpc/vpc-networking.yml"
                stackName="voodoo-vpc"
                capabilities="CAPABILITY_NAMED_IAM"
                profile=$deploy_profile
                region=$deploy_to_region
                paramsFile="network/vpc/vpc-networking-params"

                deploy_aws_resource $templatePath \
                                    $stackName \
                                    $capabilities \
                                    $profile \
                                    $region \
                                    $paramsFile 
                                    
                echo "Finished deploying $resource ..." ;;  

   "network/dns") 
                echo "Start deploying $resource ..."
                templatePath="network/dns/private-dns-namespace.yml"
                stackName="voodoo-dns-private-namespace"
                capabilities="CAPABILITY_NAMED_IAM"
                profile=$deploy_profile
                region=$deploy_to_region

                deploy_aws_resource_no_params $templatePath \
                                              $stackName \
                                              $capabilities \
                                              $profile \
                                              $region 
                                    
                echo "Finished deploying $resource ..." ;; 

   "network/security-group") 
                echo "Start deploying $resource ..."
                templatePath="network/security-group/security-groups.yml"
                stackName="voodoo-security-groups"
                capabilities="CAPABILITY_NAMED_IAM"
                profile=$deploy_profile
                region=$deploy_to_region

                deploy_aws_resource_no_params $templatePath \
                                              $stackName \
                                              $capabilities \
                                              $profile \
                                              $region 
                                    
                echo "Finished deploying $resource ..." ;;  

   "network/service-discovery/kafka") 
                echo "Start deploying $resource ..."
                templatePath="network/service-discovery/kafka/kafka-service-discovery-service.yml"
                stackName="voodoo-service-discovery-kafka"
                capabilities="CAPABILITY_NAMED_IAM"
                profile=$deploy_profile
                region=$deploy_to_region
                paramsFile="network/service-discovery/kafka/kafka-service-discovery-service-params"

                deploy_aws_resource $templatePath \
                                    $stackName \
                                    $capabilities \
                                    $profile \
                                    $region \
                                    $paramsFile 
                                    
                echo "Finished deploying $resource ..." ;;  

   "network/service-discovery/redis") 
                echo "Start deploying $resource ..."
                templatePath="network/service-discovery/redis/redis-service-discovery-service.yml"
                stackName="voodoo-service-discovery-redis"
                capabilities="CAPABILITY_NAMED_IAM"
                profile=$deploy_profile
                region=$deploy_to_region
                paramsFile="network/service-discovery/redis/redis-service-discovery-service-params"

                deploy_aws_resource $templatePath \
                                    $stackName \
                                    $capabilities \
                                    $profile \
                                    $region \
                                    $paramsFile 
                                    
                echo "Finished deploying $resource ..." ;;  

   "network/load-balancer/alb") 
                echo "Start deploying $resource ..."
                templatePath="network/load-balancer/alb.yml"
                stackName="voodoo-alb"
                capabilities="CAPABILITY_NAMED_IAM"
                profile=$deploy_profile
                region=$deploy_to_region

                deploy_aws_resource_no_params $templatePath \
                                              $stackName \
                                              $capabilities \
                                              $profile \
                                              $region 
                                    
                echo "Finished deploying $resource ..." ;;  

   "network/load-balancer/nlb") 
                echo "Start deploying $resource ..."
                templatePath="network/load-balancer/nlb.yml"
                stackName="voodoo-nlb"
                capabilities="CAPABILITY_NAMED_IAM"
                profile=$deploy_profile
                region=$deploy_to_region

                deploy_aws_resource_no_params $templatePath \
                                              $stackName \
                                              $capabilities \
                                              $profile \
                                              $region 
                                    
                echo "Finished deploying $resource ..." ;;  

### IAM resources

   "iam/task-role") 
                echo "Start deploying $resource ..."
                templatePath="iam/task-role.yml"
                stackName="voodoo-iam-task-roles"
                capabilities="CAPABILITY_NAMED_IAM"
                profile=$deploy_profile
                region=$deploy_to_region

                deploy_aws_resource_no_params $templatePath \
                                              $stackName \
                                              $capabilities \
                                              $profile \
                                              $region 
                                    
                echo "Finished deploying $resource ..." ;; 

   "iam/execution-role") 
                echo "Start deploying $resource ..."
                templatePath="iam/execution-role.yml"
                stackName="voodoo-iam-execution-roles"
                capabilities="CAPABILITY_NAMED_IAM"
                profile=$deploy_profile
                region=$deploy_to_region

                deploy_aws_resource_no_params $templatePath \
                                              $stackName \
                                              $capabilities \
                                              $profile \
                                              $region 
                                    
                echo "Finished deploying $resource ..." ;; 

### ECS resources
    
    ### Cluster

   "ecs/cluster") 
                echo "Start deploying $resource ..."
                templatePath="ecs/cluster/ecs-cluster.yml"
                stackName="voodoo-ecs-cluster"
                capabilities="CAPABILITY_NAMED_IAM"
                profile=$deploy_profile
                region=$deploy_to_region
                paramsFile="ecs/cluster/ecs-cluster-params"

                deploy_aws_resource $templatePath \
                                    $stackName \
                                    $capabilities \
                                    $profile \
                                    $region \
                                    $paramsFile 
                                    
                echo "Finished deploying $resource ..." ;;

    ### Task

   "ecs/task/api") 
                echo "Start deploying $resource ..."
                templatePath="ecs/task/api/task-df-api.yml"
                stackName="voodoo-ecs-tdf-api"
                capabilities="CAPABILITY_NAMED_IAM"
                profile=$deploy_profile
                region=$deploy_to_region
                paramsFile="ecs/task/api/task-df-api-params"

                deploy_aws_resource $templatePath \
                                    $stackName \
                                    $capabilities \
                                    $profile \
                                    $region \
                                    $paramsFile 
                                    
                echo "Finished deploying $resource ..." ;;  

   "ecs/task/decoder") 
                echo "Start deploying $resource ..."
                templatePath="ecs/task/decoder/task-df-decoder.yml"
                stackName="voodoo-ecs-tdf-decoder"
                capabilities="CAPABILITY_NAMED_IAM"
                profile=$deploy_profile
                region=$deploy_to_region
                paramsFile="ecs/task/decoder/task-df-decoder-params"

                deploy_aws_resource $templatePath \
                                    $stackName \
                                    $capabilities \
                                    $profile \
                                    $region \
                                    $paramsFile 
                                    
                echo "Finished deploying $resource ..." ;;  

   "ecs/task/kafka") 
                echo "Start deploying $resource ..."
                templatePath="ecs/task/kafka/task-df-kafka.yml"
                stackName="voodoo-ecs-tdf-kafka"
                capabilities="CAPABILITY_NAMED_IAM"
                profile=$deploy_profile
                region=$deploy_to_region
                paramsFile="ecs/task/kafka/task-df-kafka-params"

                deploy_aws_resource $templatePath \
                                    $stackName \
                                    $capabilities \
                                    $profile \
                                    $region \
                                    $paramsFile 
                                    
                echo "Finished deploying $resource ..." ;;  

   "ecs/task/netty-pos") 
                echo "Start deploying $resource ..."
                templatePath="ecs/task/netty/pos/task-df-netty-pos.yml"
                stackName="voodoo-ecs-tdf-netty-pos"
                capabilities="CAPABILITY_NAMED_IAM"
                profile=$deploy_profile
                region=$deploy_to_region
                paramsFile="ecs/task/netty/pos/task-df-netty-pos-params"

                deploy_aws_resource $templatePath \
                                    $stackName \
                                    $capabilities \
                                    $profile \
                                    $region \
                                    $paramsFile 
                                    
                echo "Finished deploying $resource ..." ;;  

   "ecs/task/netty-pat") 
                echo "Start deploying $resource ..."
                templatePath="ecs/task/netty/pat/task-df-netty-pat.yml"
                stackName="voodoo-ecs-tdf-netty-pat"
                capabilities="CAPABILITY_NAMED_IAM"
                profile=$deploy_profile
                region=$deploy_to_region
                paramsFile="ecs/task/netty/pat/task-df-netty-pat-params"

                deploy_aws_resource $templatePath \
                                    $stackName \
                                    $capabilities \
                                    $profile \
                                    $region \
                                    $paramsFile 
                                    
                echo "Finished deploying $resource ..." ;;  

   "ecs/task/redis") 
                echo "Start deploying $resource ..."
                templatePath="ecs/task/redis/task-df-redis.yml"
                stackName="voodoo-ecs-tdf-redis"
                capabilities="CAPABILITY_NAMED_IAM"
                profile=$deploy_profile
                region=$deploy_to_region
                paramsFile="ecs/task/redis/task-df-redis-params"

                deploy_aws_resource $templatePath \
                                    $stackName \
                                    $capabilities \
                                    $profile \
                                    $region \
                                    $paramsFile 
                                    
                echo "Finished deploying $resource ..." ;;  

   "ecs/task/simulator") 
                echo "Start deploying $resource ..."
                templatePath="ecs/task/simulator/task-df-simulator.yml"
                stackName="voodoo-ecs-tdf-simulator"
                capabilities="CAPABILITY_NAMED_IAM"
                profile=$deploy_profile
                region=$deploy_to_region
                paramsFile="ecs/task/simulator/task-df-simulator-params"

                deploy_aws_resource $templatePath \
                                    $stackName \
                                    $capabilities \
                                    $profile \
                                    $region \
                                    $paramsFile 
                                    
                echo "Finished deploying $resource ..." ;;  

    ### Service

   "ecs/service/api") 
                echo "Start deploying $resource ..."
                templatePath="ecs/service/api/service-api.yml"
                stackName="voodoo-ecs-service-api"
                capabilities="CAPABILITY_NAMED_IAM"
                profile=$deploy_profile
                region=$deploy_to_region
                paramsFile="ecs/service/api/service-api-params"

                deploy_aws_resource $templatePath \
                                    $stackName \
                                    $capabilities \
                                    $profile \
                                    $region \
                                    $paramsFile 
                                    
                echo "Finished deploying $resource ..." ;;  

   "ecs/service/decoder") 
                echo "Start deploying $resource ..."
                templatePath="ecs/service/decoder/service-decoder.yml"
                stackName="voodoo-ecs-service-decoder"
                capabilities="CAPABILITY_NAMED_IAM"
                profile=$deploy_profile
                region=$deploy_to_region
                paramsFile="ecs/service/decoder/service-decoder-params"

                deploy_aws_resource $templatePath \
                                    $stackName \
                                    $capabilities \
                                    $profile \
                                    $region \
                                    $paramsFile 
                                    
                echo "Finished deploying $resource ..." ;;  

   "ecs/service/kafka") 
                echo "Start deploying $resource ..."
                templatePath="ecs/service/kafka/service-kafka.yml"
                stackName="voodoo-ecs-service-kafka"
                capabilities="CAPABILITY_NAMED_IAM"
                profile=$deploy_profile
                region=$deploy_to_region
                paramsFile="ecs/service/kafka/service-kafka-params"

                deploy_aws_resource $templatePath \
                                    $stackName \
                                    $capabilities \
                                    $profile \
                                    $region \
                                    $paramsFile 
                                    
                echo "Finished deploying $resource ..." ;;  

   "ecs/service/netty-pos") 
                echo "Start deploying $resource ..."
                templatePath="ecs/service/netty/pos/service-netty-pos.yml"
                stackName="voodoo-ecs-service-netty-pos"
                capabilities="CAPABILITY_NAMED_IAM"
                profile=$deploy_profile
                region=$deploy_to_region
                paramsFile="ecs/service/netty/pos/service-netty-pos-params"

                deploy_aws_resource $templatePath \
                                    $stackName \
                                    $capabilities \
                                    $profile \
                                    $region \
                                    $paramsFile 
                                    
                echo "Finished deploying $resource ..." ;;  

   "ecs/service/netty-pat") 
                echo "Start deploying $resource ..."
                templatePath="ecs/service/netty/pat/service-netty-pat.yml"
                stackName="voodoo-ecs-service-netty-pat"
                capabilities="CAPABILITY_NAMED_IAM"
                profile=$deploy_profile
                region=$deploy_to_region
                paramsFile="ecs/service/netty/pat/service-netty-pat-params"

                deploy_aws_resource $templatePath \
                                    $stackName \
                                    $capabilities \
                                    $profile \
                                    $region \
                                    $paramsFile 
                                    
                echo "Finished deploying $resource ..." ;;  

   "ecs/service/redis") 
                echo "Start deploying $resource ..."
                templatePath="ecs/service/redis/service-redis.yml"
                stackName="voodoo-ecs-service-redis"
                capabilities="CAPABILITY_NAMED_IAM"
                profile=$deploy_profile
                region=$deploy_to_region
                paramsFile="ecs/service/redis/service-redis-params"

                deploy_aws_resource $templatePath \
                                    $stackName \
                                    $capabilities \
                                    $profile \
                                    $region \
                                    $paramsFile 
                                    
                echo "Finished deploying $resource ..." ;;  

   "ecs/service/simulator") 
                echo "Start deploying $resource ..."
                templatePath="ecs/service/simulator/service-simulator.yml"
                stackName="voodoo-ecs-service-simulator"
                capabilities="CAPABILITY_NAMED_IAM"
                profile=$deploy_profile
                region=$deploy_to_region
                paramsFile="ecs/service/simulator/service-simulator-params"

                deploy_aws_resource $templatePath \
                                    $stackName \
                                    $capabilities \
                                    $profile \
                                    $region \
                                    $paramsFile 
                                    
                echo "Finished deploying $resource ..." ;;  

   *) echo "Sorry, I can not get a $resource resource for you!";;
esac