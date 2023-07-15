output "zone_id" {
  value = data.cloudflare_zone.default.id
}

output "tags" {
  value = var.tags
}
