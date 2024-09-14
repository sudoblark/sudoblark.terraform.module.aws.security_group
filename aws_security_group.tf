resource "aws_security_group" "groups" {
  for_each = { for group in var.raw_security_groups : group.suffix => group }

  name = upper(format("aws-%s-%s-%s-SG",
    var.environment,
    var.application_name,
    each.value["suffix"])
  )
  description = format("%s - Managed by Terraform", each.value["description"])
  vpc_id      = var.vpc_config
}