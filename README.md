# sudoblark.terraform.module.aws.security_group
Terraform module to create N number of security groups and their associated rules. - repo managed by sudoblark.terraform.github

## Developer documentation
The below documentation is intended to assist a developer with interacting with the Terraform module in order to add,
remove or update functionality.

### Pre-requisites
* terraform_docs

```sh
brew install terraform_docs
```

* tfenv
```sh
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bash_profile
```

* Virtual environment with pre-commit installed

```sh
python3 -m venv venv
source venv/bin/activate
pip install pre-commit
```
### Pre-commit hooks
This repository utilises pre-commit in order to ensure a base level of quality on every commit. The hooks
may be installed as follows:

```sh
source venv/bin/activate
pip install pre-commit
pre-commit install
pre-commit run --all-files
```

# Module documentation
The below documentation is intended to assist users in utilising the module, the main thing to note is the
[data structure](#data-structure) section which outlines the interface by which users are expected to interact with
the module itself, and the [examples](#examples) section which has examples of how to utilise the module.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.61.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.67.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group.groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | Name of the application utilising resource. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Which environment this is being instantiated in. | `string` | n/a | yes |
| <a name="input_raw_security_groups"></a> [raw\_security\_groups](#input\_raw\_security\_groups) | Data structure<br>---------------<br>A list of dictionaries, where each dictionary has the following attributes:<br><br>REQUIRED<br>---------<br>- suffix                : Security group suffix to use for naming and unique identifiers<br>- description           : Description to give to the security group<br><br>OPTIONAL<br>---------<br>- rules: A list of dictionaries, where each dictionary has the following values:<br>-- name                 : Friendly name used through Terraform for instantiation and cross-referencing<br>-- type                 : Ingress/egress<br>-- from\_port            : Start port<br>-- to\_port              : End port<br>-- protocol             : Protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number.<br>-- description          : Friendly description of the rule, required for auditing purposes.<br><br>In addition, the following optional args are available:<br>-- cidr\_blocks               : List of CIDR blocks. Cannot be specified with source\_security\_group\_id or self.<br>-- ipv6\_cidr\_blocks          : List of IPv6 CIDR blocks. Cannot be specified with source\_security\_group\_id or self.<br>-- prefix\_list\_ids           : List of Prefix List IDs.<br>-- self                      : Whether the security group itself will be added as a source to this ingress rule. Cannot be specified with cidr\_blocks, ipv6\_cidr\_blocks, or source\_security\_group\_id.<br>-- source\_security\_group\_id  : Security group id to allow access to/from, depending on the type. Cannot be specified with cidr\_blocks, ipv6\_cidr\_blocks, or self. | <pre>list(<br>    object({<br>      suffix : string,<br>      description : string,<br>      rules : optional(list(<br>        object({<br>          name                     = string,<br>          type                     = string,<br>          from_port                = string,<br>          to_port                  = string,<br>          protocol                 = string,<br>          description              = string,<br>          cidr_blocks              = optional(list(string), null),<br>          ipv6_cidr_blocks         = optional(list(string), null),<br>          prefix_list_ids          = optional(list(string), null),<br>          self                     = optional(bool, null),<br>          source_security_group_id = optional(string, null)<br>        })<br>      ), [])<br><br>    })<br>  )</pre> | n/a | yes |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | AWS VPC ID within which to create the security group. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Data structure
```
Data structure
---------------
A list of dictionaries, where each dictionary has the following attributes:

REQUIRED
---------
- suffix                : Security group suffix to use for naming and unique identifiers
- description           : Description to give to the security group

OPTIONAL
---------
- rules: A list of dictionaries, where each dictionary has the following values:
-- name                 : Friendly name used through Terraform for instantiation and cross-referencing
-- type                 : Ingress/egress
-- from_port            : Start port
-- to_port              : End port
-- protocol             : Protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number.
-- description          : Friendly description of the rule, required for auditing purposes.

In addition, the following optional args are available:
-- cidr_blocks               : List of CIDR blocks. Cannot be specified with source_security_group_id or self.
-- ipv6_cidr_blocks          : List of IPv6 CIDR blocks. Cannot be specified with source_security_group_id or self.
-- prefix_list_ids           : List of Prefix List IDs.
-- self                      : Whether the security group itself will be added as a source to this ingress rule. Cannot be specified with cidr_blocks, ipv6_cidr_blocks, or source_security_group_id.
-- source_security_group_id  : Security group id to allow access to/from, depending on the type. Cannot be specified with cidr_blocks, ipv6_cidr_blocks, or self.
```

## Examples
See `examples` folder for an example setup.
