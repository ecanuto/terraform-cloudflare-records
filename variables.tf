variable "zone" {
  type        = string
  description = "The DNS zone name in which record will be added."
}

variable "address" {
  type        = string
  default     = ""
  description = "The default address to be used for DNS records."
}

variable "records" {
  type        = list(any)
  default     = null
  description = <<-DOC
    name:
      The name of the record.
    type:
      The type of the record.
    value:
      The value of the record.
    ttl:
      The TTL of the record.
      Default value: 1.
    priority:
      The priority of the record. 
    proxied:
      Whether the record gets Cloudflare's origin protection. 
      Default value: false.
  DOC
}
