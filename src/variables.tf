variable "region" {
  type        = string
  description = "AWS Region"
}

variable "transit_gateway_id" {
  type        = string
  description = "ID of the Transit Gateway to attach to"
}

variable "transit_gateway_route_table_id" {
  type        = string
  description = "ID of the Transit Gateway Route Table"
}

variable "transit_gateway_attachment_subnet_name" {
  type        = string
  description = <<-EOT
    The name of the subnet where the TGW attachment is created.
    By default, it is created in all private subnets of the VPC.
    Use this to avoid duplicate attachments when a VPC has multiple subnets in the same AZ,
    as there’s no benefit in creating more than one attachment per AZ.
  EOT
  default     = ""
  nullable    = false
}

variable "vpc_component_name" {
  type        = string
  description = "The name of the vpc component"
  default     = "vpc"
}
