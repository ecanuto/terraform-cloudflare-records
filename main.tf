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
  name     = try(each.value.name, var.zone)
  type     = try(each.value.type, "A")
  value    = try(each.value.value, null)
  priority = try(each.value.priority, null)
  proxied  = try(each.value.proxied, false)
  ttl      = try(each.value.ttl, var.ttl)
  comment  = try(each.value.comment, var.comment)
  tags     = try(each.value.tags, var.tags)
}
