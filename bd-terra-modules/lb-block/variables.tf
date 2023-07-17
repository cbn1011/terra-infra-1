variable "lb-name" {
    type    = string
    default = "BD-UAE-LB"
}
variable "tg_name" {
  type    = string
  default = "TG-messaging"
}
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["Bestdoc-Uae-MyVPC."]
  }
}
data "aws_subnets" "vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
  tags = {
    TIer = "Public"
  }
}
data "aws_subnet" "vpc_subnet" {
  for_each = toset(data.aws_subnets.vpc_subnets.ids)
  id       = each.value
}
# output "subnets" {
#   value = [for s in data.data.aws_subnet.vpc_subnet : s.cidr_blocks]
# }
variable "tg-details" {
  type = object({
    path = string
    domain = string
  })
  default = {
    path = "/*"
    domain = "messaging.bestdoc.ae"
  }
}