terraform {
  required_version = ">= 1.1.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "> 3.5"
    }
  }
}

locals {
  records = {
    for idx, record in flatten(var.records) :
      "record-${idx}" => record
  }
}

data "cloudflare_zone" "default" {
  name = var.zone
}

resource "cloudflare_record" "default" {
  for_each = local.records

  zone_id  = data.cloudflare_zone.default.id
  name     = lookup(each.value, "name", var.zone)
  type     = lookup(each.value, "type", "A")
  value    = lookup(each.value, "value", var.address)
  priority = lookup(each.value, "priority", null)
  proxied  = lookup(each.value, "proxied", false)
  ttl      = lookup(each.value, "ttl", var.ttl)
  comment  = lookup(each.value, "comment", var.comment)
  tags     = lookup(each.value, "tags", var.tags)
}
