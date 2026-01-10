variable "hcloud_token" {
  description = "Hetzner Cloud API token (set via TF_VAR_hcloud_token)"
  type        = string
  sensitive   = true
}

variable "location" {
  description = "Hetzner location"
  type        = string
  default     = "fsn1"
}

variable "image" {
  description = "Server image"
  type        = string
  default     = "ubuntu-22.04"
}

variable "server_type" {
  description = "Server type"
  type        = string
  default     = "cx23"
}

variable "lb_type" {
  description = "Load balancer type"
  type        = string
  default     = "lb11"
}
