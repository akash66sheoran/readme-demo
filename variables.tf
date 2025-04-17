variable "environment" {
  type = string
}

variable "maintainedBy" {
  type = string
}

variable "application" {
  type = string
  description = "Usage/purpose of the server"
}

variable "sg_inbound_rules" {
  type = map(object({
    source = string
    from_port = number
    to_port = number
    ip_protocol = string
  }))
}

variable "sg_name" {
  type = string
}

variable "vpc_id" {
  type = string
  default = ""
}

variable "instances" {
  type = map(object({
    ami = string
    instance_type = string
    key_name = string
    subnet_id = string
    vpc_security_group_ids = optional(list(string), [])
    root_block_device = object({
      volume_size = number
      volume_type = string
    })
    ebs_block_device = optional(list(object({
      device_name = string
      volume_size = number
      volume_type = string
    })), [])
    tags = optional(map(string), {})
  }))
}

variable "iam_instance_profile" {
  type = string
}

variable "ec2_role_name" {
  type = string
}

variable "managed_policy_arns" {
  type        = list(string)
  default     = []
}