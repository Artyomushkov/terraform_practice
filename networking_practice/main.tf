variable "network" {
  type = string
  default = "10.217.144.0/21"
}

locals {
  subnets = cidrsubnets(var.network, 1, 2, 2)
  first = cidrsubnets(local.subnets[0], 1, 4)
  second = cidrsubnets(local.subnets[1], 1, 4)
  third = cidrsubnets(local.subnets[2], 1, 4)
}

output "results" {
  value = concat(local.first, local.second, local.third)
}