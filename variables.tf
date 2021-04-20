variable "dnssec" {
  description = "Should we enable DNSSEC and create required resources?"
  type = bool
  default = false
}

variable "domain_name" {
  description = "The name/fqdn of the Route53 Zone."
  type = string
}

variable "signing_key_name" {
    description = "The name to use for the DNSSEC signing key, must be alphanumeric only, no -, _, or spaces."
    default = "DefaultSigningKey"
}

variable "ttl" {
  description = "The value to use in seconds for TTL of the DS records"
  default = 300
  type = number
}

variable "deletion_window_days" {
  description = "The number of days to use for holding the kms key after delete."
  default = 14
  type = number
}

variable "key_alias_name" {
  description = "The name of the KMS key alias."
  default = "DNSSEC-Key"
  type = string
}