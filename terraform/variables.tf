variable "newrelic_license_key" {
  description = "New Relic ingest license key"
  type        = string
  sensitive   = true
  default     = "" # fallback if env var is missing
}

variable "dockerhub_username" {
  type      = string
  sensitive = true
}

variable "dockerhub_password" {
  type      = string
  sensitive = true
}