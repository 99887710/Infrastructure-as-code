# [DevOps] Infrastructure-as-code
Using *AWS Cloudformation* to demo Infrastructure-as-code (IaC) concept

Infrastructure-as-code (IaC) is a concept focusing on how to deliver environments in a consistent, efficient way.

Automatically provisioning your resources to different environments greatly improve the system stability and consistency.

Advantages:
1) Automation provisioning
2) Version control
3) Integration with CI/CD 
4) Fast reflication

## Tech Roadmap
 
Voodoo Infra uses a number of AWS services to work together, see below: 
 
* [ECS] - is a highly scalable, high performance container orchestration service that supports Docker containers ! 
* [ECR] - is a fully-managed Docker container registry 
* [VPC] -  lets you provision a logically isolated section of the AWS Cloud  
* [EC2] - is a web service that provides secure, resizable compute capacity in the cloud 
* [Route53] -  is a highly available and scalable cloud Domain Name System (DNS) web service 
* [Cloud Map] - Service discovery for cloud resources 
* [CloudFormation] - a common language for you to describe and provision all the infrastructure resources  

### Current Resource Hierarchy  
 
1. Network 
    - vpc 
    - dns 
    - load balancer 
      - application load balancer (api) 
      - network load balancer (netty pos/pat) 
    - security group 
    - service discovery 
        - kafka 
        - redis 
2. IAM 
    - Execution Role 
    - Task Role 
3. ECS 
    - cluster 
    - service 
        - api 
        - decoder 
        - kafka 
        - netty 
            - pos 
            - pat 
        - redis 
    - task 
        - api 
        - decoder 
        - kafka 
        - netty 
            - pos 
            - pat 
        - redis 
  
### Development 
 
>[ECR images cross-region bulk migration] 
```sh 
syntax: 
    ./ecr-image-bulk-migrate.sh src_region dst_region account_id profile 
``` 
 
e.g. 
    ./ecr-image-bulk-migrate.sh  ***[eu-west-1]*** ***[eu-west-2]*** ***[Account Id]*** ***[AWS Profile]***  
 
>[ECR image cross-region single migration] 
```sh 
syntax: 
    ./ecr-image-migrate.sh src_region dst_region account_id repo src_tag dst_tag profile  
``` 
 
e.g. 
    ./ecr-image-migrate.sh ***[eu-west-1]*** ***[eu-west-2]*** ***[Account Id]*** ***[Src ECR Repo]*** ***[Src ECR Tag]*** ***[Dst ECR Tag]*** ***[AWS Profile]*** 
 
 
>[Deploy aws resources] 
 
1. Deploy with aws-deploy.sh  *[Recommended]* 
```sh 
syntax: 
    ./aws-deploy.sh path-to-resource 
``` 
e.g. 
    ./aws-deploy.sh ***ecs/service/redis*** 
 
2. Deploy with aws-cli 
 ```sh 
syntax: 
    aws cloudformation deploy --template-file --stack-name --parameter-overrides --capabilities --profile --region  
``` 
e.g.  
aws cloudformation deploy --template-file task-df-api.yml --stack-name voodoo-ecs-df-http --parameter-overrides $(cat task-df-api-params | tr "\n\r" " ") --capabilities CAPABILITY_NAMED_IAM  --profile ***AWS Profile***  --region eu-west-2 
 
*ref*: https://docs.aws.amazon.com/cli/latest/reference/cloudformation/deploy/index.html  
