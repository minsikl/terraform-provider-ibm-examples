variable "iks_cluster" {
  default = {
    name                   = "iks_cluster"
    machine_type           = "free"
    default_pool_size      = 1
  }
}

variable datacenter {
  description = "IBM datacenter code"
  default     = ""
}
