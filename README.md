# Terraform Cloudflare Records

Terraform module to provision a CloudFlare DNS records.

## Usage:

Using default address:

```hcl
module "cygnus_dns_records" {
  source = "github.com/ecanuto/terraform-cloudflare-records"

  zone    = "mydomain.com"
  address = "192.168.0.11"
  records = [
    { type = "A", name = "api" },
    { type = "A", name = "www", ttl = 1, proxied = true },
  ]
}
```

One IP per record:

```hcl
module "cygnus_dns_records" {
  source = "github.com/ecanuto/terraform-cloudflare-records"

  zone    = "mydomain.com"
  records = [
    { type = "A", name = "api", value = "192.168.0.11" },
    { type = "A", name = "www", value = "192.168.0.12", ttl = 1, proxied = true },
  ]
}
```

## Requirements

terraform >= 1.1.0  
cloudflare >= 3.0.0
