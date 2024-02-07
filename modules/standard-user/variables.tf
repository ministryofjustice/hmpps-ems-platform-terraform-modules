variable "username" {
  type        = string
  description = "The name of the user."
}


variable "full_name" {
  type        = string
  description = "The users full name. Used for resource tagging."
}


variable "organisation" {
  type        = string
  description = "The users organisation. Used for resource tagging."
}


variable "email" {
  type        = string
  description = "The users email address. Used for resource tagging."
}


variable "cjsm_email" {
  type        = string
  description = "The users cjsm email address. Used for sending credentials."
  default     = ""
}


variable "group_membership" {
  type        = list(string)
  description = "A list of groups that the user will be added to. Every user will automatically be added to the MFA group."
  default     = []
}


variable "path" {
  type        = string
  description = "The path to assign to the created user."
  default     = "/"
}


variable "force_destroy" {
  type        = string
  description = "Destroy the user even if it has an unmanaged login profile or access keys."
  default     = "true"
}


variable "tags" {
  type        = map(string)
  description = "A list of tags that will be applied to deployed resources."
}


locals {
  tags = merge(var.tags,
    {
      organisation = var.organisation
      email        = var.email
      cjsm_email   = var.cjsm_email
      name         = var.full_name
    }
  )
  default_group_membership = [
    "hmpps-mfa-users-group"
  ]
  group_membership = concat(local.default_group_membership, var.group_membership)
}
