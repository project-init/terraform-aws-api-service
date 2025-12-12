module "grpc_service" {
  source = "project-init/grpc-service/aws"
  # Project Init recommends pinning every module to a specific version
  # version = "vX.X.X"

  # Common
  environment  = "staging"
  service_name = "api"

  # ECS Cluster/Service
  ecs_cluster_name = "cluster"
  ecs_cluster_arn  = "cluster:arn"
  subnets = [
    "subnet-1"
  ]
  security_groups = [
    "sg-1"
  ]

  # ECS Task
  image = "111111111111.dkr.ecr.us-east-1.amazonaws.com/api:v0.1.0"
  environment_variables = [
    {
      name  = "REGION"
      value = "us-east-1"
    },
  ]

  cpu    = 256
  memory = 256

  desired_count = 1
  min_capacity  = 1
  max_capacity  = 1
}