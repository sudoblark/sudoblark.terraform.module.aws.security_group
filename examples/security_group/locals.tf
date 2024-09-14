locals {
  raw_security_groups = [
    {
      "suffix" : "lambda",
      "description" : "Lambda Function security group",
      "rules" : [
        {
          "name" : "All traffic from VPC",
          "type" : "ingress",
          "from_port" : "0",
          "to_port" : "0",
          "protocol" : "-1",
          "description" : "VPC Traffic (Ingress)",
          "cidr_blocks" : ["1.2.3.0/24"]
        },
        {
          "name" : "All traffic to VPC",
          "type" : "egress",
          "from_port" : "0",
          "to_port" : "0",
          "protocol" : "-1",
          "description" : "VPC Traffic (Egress)",
          "cidr_blocks" : ["1.2.3.0/24"]
        },
        {
          "name" : "Public endpoint traffic",
          "type" : "egress",
          "from_port" : "443",
          "to_port" : "443",
          "protocol" : "tcp",
          "description" : "Public Endpoint traffic (Egress)",
          "cidr_blocks" : ["0.0.0.0/0"]
        }
      ]
    }
  ]
}