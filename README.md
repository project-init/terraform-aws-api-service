# Project Init AWS API Service

Module used to help create the ECS infrastructure for an API server. This is an opinionated module, and assumes that a
load balancer and target group exists that the service will be attached to. For that reason all that is needed is the
target group, and the module assumes everything else is in place to manage the traffic to the API service.

## Quick Start

1. `mise format`
2. `mise docs`

## Usage

Check our [Examples](examples) for full usage information.

## Useful Docs

* [Code of Conduct](./CODE_OF_CONDUCT.md)
* [Contribution Guide](./CONTRIBUTING.md)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.81.0 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->