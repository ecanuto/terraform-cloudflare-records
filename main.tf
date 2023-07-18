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
    for record in flatten(var.records) :
    try(
      record.key,
      md5(jsonencode([
        try(record.type, null),
        try(record.name, var.zone),
        try(record.value, null),
        try(record.data, null)
      ]))
    ) => record
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

  allow_overwrite = try(each.value.allow_overwrite, false)

  dynamic "data" {
    for_each = try([each.value.data], [])
    content {
      tag   = try(data.value.tag, null)
      flags = try(data.value.flags, null)
      value = try(data.value.value, null)
    }
  }
}
