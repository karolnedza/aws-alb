variable termination_enabled {
  type        = string
  default     = true
  description = "description"
}



locals {
  terminate   = var.termination_enabled
}