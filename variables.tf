# Input variable definitions
variable "environment" {
  description = "Which environment this is being instantiated in."
  type        = string
  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Must be either dev, test or prod"
  }
}

variable "application_name" {
  description = "Name of the application utilising resource."
  type        = string
}

variable "vpc_config" {
  description = "AWS VPC ID within which to create the security group."
  type        = string
}

variable "raw_security_groups" {
  description = <<EOF

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

EOF
  type = list(
    object({
      suffix : string,
      description : string,
      rules : optional(list(
        object({
          name                     = string,
          type                     = string,
          from_port                = string,
          to_port                  = string,
          protocol                 = string,
          description              = string,
          cidr_blocks              = optional(list(string), null),
          ipv6_cidr_blocks         = optional(list(string), null),
          prefix_list_ids          = optional(list(string), null),
          self                     = optional(bool, null),
          source_security_group_id = optional(string, null)
        })
      ), [])

    })
  )
}