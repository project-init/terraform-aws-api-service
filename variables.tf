########################################################################################################################
### Common
########################################################################################################################

variable "environment" {
  type        = string
  nullable    = false
  description = "The environment to deploy the api service to."
}

variable "service_name" {
  type        = string
  nullable    = false
  description = "The name of the service."
}

########################################################################################################################
### ECS Cluster/Service
########################################################################################################################

variable "ecs_cluster_arn" {
  type        = string
  description = "The ARN of the ecs cluster to deploy the service on."
}

variable "ecs_cluster_name" {
  type        = string
  description = "The name of the ecs cluster to deploy the service on."
}

variable "subnets" {
  type        = set(string)
  description = "The subnets to deploy the service in to."
}

variable "security_groups" {
  type        = list(string)
  description = "IDs of the extra security groups you want the task to have access to."
}

variable "use_ec2" {
  type        = bool
  default     = false
  description = "Whether to deploy the service on an ec2 backed service or fargate."
}

variable "capacity_providers" {
  default = []
  type = set(object({
    capacity_provider = string
    base              = number
    weight            = number
  }))
  description = "List of capacity providers to use for distributing tasks. Should primarily be used when utilizing ec2 backed ecs."
}

variable "ordered_placement_strategies" {
  default = []
  type = set(object({
    type  = string
    field = string
  }))
  description = "List of ordered placement strategies to use for distributing tasks. Should primarily be used when utilizing ec2 backed ecs."
}

variable "force_new_deployment" {
  type        = bool
  default     = false
  description = "Whether to force a new deployment when updating the ecs service."
}

########################################################################################################################
### ECS Task
########################################################################################################################

variable "environment_variables" {
  type = list(object({
    name  = string
    value = string
  }))
  default     = []
  description = "The environment variables to use for the service."
}

variable "log_level" {
  type        = string
  default     = "info"
  description = "Default value for LOG_LEVEL."

  validation {
    condition     = contains(["debug", "info", "warn", "error"], var.log_level)
    error_message = "Log level must be one of: debug, info, warn, error."
  }
}

variable "log_add_source" {
  type        = bool
  default     = false
  description = "Default value for LOG_ADD_SOURCE."
}

variable "secrets" {
  type = list(object({
    name      = string
    valueFrom = string
  }))
  default     = []
  description = "The secrets to use for the service."
}

variable "image" {
  type        = string
  nullable    = false
  description = "The docker image to use for the container."
}

variable "desired_count" {
  type        = number
  default     = 0
  description = "Desired count of tasks to run. This is ignored after the first apply."
}

variable "max_capacity" {
  type        = number
  default     = 0
  description = "The maximum amount of the tasks to run."
}

variable "min_capacity" {
  type        = number
  default     = 0
  description = "The minimum amount of the tasks to run."
}

variable "cpu" {
  type        = number
  default     = 256
  description = "The cpu value to give to the ecs task."
}

variable "memory" {
  type        = number
  default     = 512
  description = "The memory value to give to the ecs task."
}

variable "sidecars" {
  type = list(object({
    name                  = string
    image                 = string
    essential             = optional(bool, false)
    environment_variables = optional(list(object({ name = string, value = string })), [])
    secrets               = optional(list(object({ name = string, valueFrom = string })), [])
    port_mappings = optional(list(object({ containerPort = number, hostPort = number,
    protocol = string })), [])
    cpu    = optional(number, 0)
    memory = optional(number, 0)
  }))
  default     = []
  description = "Additional sidecar containers to run alongside the main container in the same task definition."
}

variable "sidecars_cpu" {
  type        = number
  default     = 0
  description = "The total combined cpu value for all sidecars."
}

variable "sidecars_memory" {
  type        = number
  default     = 0
  description = "The total combined memory value for all sidecars."
}

variable "container_port" {
  default     = 9001
  type        = number
  description = "The port the api service runs on."
}

########################################################################################################################
### Load Balancer/Routing
########################################################################################################################

variable "api_target_group_arn" {
  type        = string
  nullable    = false
  description = "The Target Group ARN for the API (assumes already built in to the traffic management apparatus)."
}

variable "vpc_id" {
  type        = string
  nullable    = false
  description = "The VPC ID being deployed to."
}

variable "lb_security_group_id" {
  type        = string
  nullable    = false
  description = "The Load Balancer's Security Group ID"
}
