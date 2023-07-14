variable "zone" {
  type        = string
  description = "The DNS zone name in which record will be added."
}

variable "address" {
  type        = string
  default     = ""
  description = "The default address to be used for all DNS records."
}

variable "ttl" {
  type        = number
  default     = 300
  description = "The default ttl to be used for all DNS records."
}

variable "tags" {
  type        = list(string)
  default     = []
  description = "The default tags to be used for all DNS records."
}

variable "comment" {
  type        = string
  default     = ""
  description = "The default comment to be used for all DNS records."
}

variable "records" {
  type        = any
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
    comment:
      Comments or notes about the DNS record.
    tags:
      Custom tags for the DNS record.
  DOC
}
