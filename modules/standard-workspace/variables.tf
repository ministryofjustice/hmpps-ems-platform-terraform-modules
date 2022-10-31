variable "bundle_id" {
  type        = string
  description = "The ID of the bundle for the WorkSpace."
}


variable "user_name" {
  type        = string
  description = "The name of the user."
  default     = "admin"
}


variable "root_volume_encryption_enabled" {
  type        = bool
  description = "Enable root volume encryption"
  default     = true
}


variable "user_volume_encryption_enabled" {
  type        = bool
  description = "Enable user volume encryption"
  default     = true
}


variable "compute_type_name" {
  type        = string
  description = "The name of the compute type. Valid options are VALUE, STANDARD, PERFORMANCE, POWER, GRAPHICS, POWERPRO, GRAPHICSPRO, GRAPHICS_G4DN, and GRAPHICSPRO_G4DN."
}


variable "user_volume_size_gib" {
  type        = string
  description = "The size of the user storage."
  default     = "0"
}


variable "root_volume_size_gib" {
  type        = string
  description = "The size of the root volume."
  default     = "0"
}


variable "running_mode" {
  type        = string
  description = "The running mode. Valid values are AUTO_STOP and ALWAYS_ON."
  default     = "AUTO_STOP"
}


variable "running_mode_auto_stop_timeout_in_minutes" {
  type        = string
  description = "The time after a user logs off when WorkSpaces are automatically stopped. Configured in 60-minute intervals."
  default     = "60"
}


variable "tags" {
  type        = map(string)
  description = "A list of tags that will be applied to deployed resources."
}


locals {
  tags = merge(var.tags,
    {

    }
  )
}
