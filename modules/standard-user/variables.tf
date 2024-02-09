variable "username" {
  type        = string
  description = "The name of the user."
  validation {
  condition     = length(var.username) > 0
  error_message = "As per https://github.com/hashicorp/terraform-provider-aws/issues/31941 tags cannot currently be empty strings."
  }
}


variable "full_name" {
  type        = string
  description = "The users full name. Used for resource tagging."
  validation {
  condition     = length(var.full_name) > 0
  error_message = "As per https://github.com/hashicorp/terraform-provider-aws/issues/31941 tags cannot currently be empty strings."
  }
}


variable "organisation" {
  type        = string
  description = "The users organisation. Used for resource tagging."
  validation {
  condition     = length(var.organisation) > 0
  error_message = "As per https://github.com/hashicorp/terraform-provider-aws/issues/31941 tags cannot currently be empty strings."
  }
}


variable "email" {
  type        = string
  description = "The users email address. Used for resource tagging."
  validation {
  condition     = length(var.email) > 0
  error_message = "As per https://github.com/hashicorp/terraform-provider-aws/issues/31941 tags cannot currently be empty strings."
  }
}


variable "cjsm_email" {
  type        = string
  description = "The users cjsm email address. Used for sending credentials."
  default     = "Unknown or to be confirmed"
  validation {
  condition     = length(var.cjsm_email) > 0
  error_message = "As per https://github.com/hashicorp/terraform-provider-aws/issues/31941 tags cannot currently be empty strings."
  }
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
  validation {
  condition     = length(var.path) > 0
  error_message = "As per https://github.com/hashicorp/terraform-provider-aws/issues/31941 tags cannot currently be empty strings."
  }
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
