output "zone_id" {
  value = data.cloudflare_zone.default.id
}

output "zone" {
  value = var.zone
}

output "tags" {
  value = var.tags
}
