locals {
  actual_security_group_rules = flatten([
    for group in var.raw_security_groups : [
      for rule in group.rules : merge(rule, {
        identifier : format("%s/%s", group.suffix, rule.name),
        security_group_id = aws_security_group.groups[group.suffix].id
      })
    ]
  ])
}

resource "aws_security_group_rule" "rule" {
  for_each          = { for rule in local.actual_security_group_rules : rule.identifier => rule }
  type              = each.value["type"]
  from_port         = each.value["from_port"]
  to_port           = each.value["to_port"]
  protocol          = each.value["protocol"]
  security_group_id = each.value["security_group_id"]
  description       = each.value["description"]

  cidr_blocks              = try(each.value["cidr_blocks"], null)
  ipv6_cidr_blocks         = try(each.value["ipv6_cidr_blocks"], null)
  prefix_list_ids          = try(each.value["prefix_list_ids"], null)
  self                     = try(each.value["self"], null)
  source_security_group_id = try(each.value["source_security_group_id"], null)

  depends_on = [
    aws_security_group.groups
  ]
}